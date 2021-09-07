import UIKit
import Combine

class HomeScreenViewController: UIViewController {

    var searchBarView: SearchBarView!
    var searchedMoviesCollectionView: UICollectionView!
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var popularMoviesCollectionView: CategorisedCollectionView!
    var topRatedMoviesCollectionView: CategorisedCollectionView!
    var trendingMoviesCollectionView: CategorisedCollectionView!

    private let widthInset: CGFloat = 36
    private let cellHeight: CGFloat = 140

    private let presenter: HomeScreenPresenter
    private let router: MovieDetailsRouterProtocol

    private var searchedMovies: [MovieViewModel] = []
    private var disposables = Set<AnyCancellable>()

    init(presenter: HomeScreenPresenter, router: MovieDetailsRouterProtocol) {
        self.presenter = presenter
        self.router = router

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
        setTrendingOptions()
    }

    private func setTrendingOptions() {
        let todayOption = OptionViewModel(id: 0, name: "Today")
        let thisWeekOption = OptionViewModel(id: 1, name: "This Week")
        trendingMoviesCollectionView.setInitialData(
            title: "Trending",
            options: [todayOption, thisWeekOption])
    }

    private func bindViews() {
        bindSearchBarView()
        bindOptionViews()
        bindMovieCollectionViews()
    }

    private func bindSearchBarView() {
        searchBarView.searchField
            .rxText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { [weak self] query -> AnyPublisher<[MovieViewModel], Error> in
                self?.presenter.searchResults(for: query) ?? .never()
            }
            .switchToLatest()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieViewModels in
                    self?.searchDidUpdate(with: movieViewModels)
                })
            .store(in: &disposables)

        searchBarView.searchField
            .onEditingStart
            .sink { [weak self] _ in
                self?.searchDidStart()
            }
            .store(in: &disposables)

        searchBarView
            .cancelButtonTap
            .sink { [weak self] _ in
                self?.searchDidEnd()
            }
            .store(in: &disposables)
    }

    private func bindOptionViews() {
        presenter
            .genres
            .map { $0.map { OptionViewModel(from: $0) } }
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] options in
                    guard let self = self else { return }

                    self.popularMoviesCollectionView.setInitialData(
                        title: "What's Popular",
                        options: options)
                    self.topRatedMoviesCollectionView.setInitialData(
                        title: "Top Rated",
                        options: options)
                })
            .store(in: &disposables)
    }

    private func bindMovieCollectionViews() {
        popularMoviesCollectionView
            .currentlySelectedCategory
            .map { [weak self] optionViewModel -> AnyPublisher<[MovieViewModel], Error> in
                self?.presenter.popularMovies(for: optionViewModel.id) ?? .never()
            }
            .switchToLatest()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieViewModels in
                    self?.popularMoviesCollectionView.setData(movieViewModels)
                })
            .store(in: &disposables)

        topRatedMoviesCollectionView
            .currentlySelectedCategory
            .map { [weak self] optionViewModel in
                self?.presenter.topRatedMovies(for: optionViewModel.id) ?? .never()
            }
            .switchToLatest()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieViewModels in
                    self?.topRatedMoviesCollectionView.setData(movieViewModels)
                })
            .store(in: &disposables)

        trendingMoviesCollectionView
            .currentlySelectedCategory
            .map { [weak self] optionViewModel -> AnyPublisher<[MovieViewModel], Error> in
                guard
                    let self = self,
                    let timeWindow = TimeWindowViewModel(rawValue: optionViewModel.id)
                else {
                    return .never()
                }

                return self.presenter.trendingMovies(for: timeWindow)
            }
            .switchToLatest()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieViewModels in
                    self?.trendingMoviesCollectionView.setData(movieViewModels)
                })
            .store(in: &disposables)

        Publishers.Merge3(
            popularMoviesCollectionView.movieSelected,
            topRatedMoviesCollectionView.movieSelected,
            trendingMoviesCollectionView.movieSelected)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieId in
                    self?.router.showMovieDetails(for: movieId)
                })
            .store(in: &disposables)

        Publishers.Merge3(
            popularMoviesCollectionView.movieFavorited,
            topRatedMoviesCollectionView.movieFavorited,
            trendingMoviesCollectionView.movieFavorited)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieId in
                    self?.presenter.toggleFavorited(for: movieId)
                })
            .store(in: &disposables)
    }

    private func searchDidStart() {
        scrollView.isHidden = true
        searchedMoviesCollectionView.isHidden = false
    }

    private func searchDidEnd() {
        searchedMoviesCollectionView.isHidden = true
        searchedMovies = []
        searchedMoviesCollectionView.reloadData()
        scrollView.isHidden = false
    }

    private func searchDidUpdate(with movies: [MovieViewModel]) {
        searchedMovies = movies
        searchedMoviesCollectionView.reloadData()
    }

}

// MARK: CollectionViewDataSource
extension HomeScreenViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        searchedMovies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = searchedMoviesCollectionView.dequeueReusableCell(
                withReuseIdentifier: MovieInfoCell.cellIdentifier,
                for: indexPath) as? MovieInfoCell,
            let movie = searchedMovies.at(indexPath.row)
        else {
            return MovieInfoCell()
        }

        cell.setData(for: movie)

        cell
            .throttledTapGesture()
            .sink { [weak self] _ in
                self?.router.showMovieDetails(for: movie.id)
            }
            .store(in: &cell.disposables)

        return cell
    }

}

// MARK: CollectionViewDelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - widthInset, height: cellHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 22, left: 0, bottom: 22, right: 0)
    }

}
