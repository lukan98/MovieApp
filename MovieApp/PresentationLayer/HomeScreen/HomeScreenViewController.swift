import UIKit
import Combine

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barStyle = .black
    }

    @objc
    func textFieldEditingDidBegin() {
        scrollView.isHidden = true
        searchedMoviesCollectionView.isHidden = false
    }

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        presenter.getSearchedMovies(with: textField.text ?? "") { [weak self] result in
            guard let self = self else { return }

            if case .success(let movies) = result {
                self.searchedMovies = movies
                self.searchedMoviesCollectionView.reloadData()
            }
        }
    }

    private func setTrendingOptions() {
        let todayOption = OptionViewModel(id: 0, name: "Today")
        let thisWeekOption = OptionViewModel(id: 1, name: "This Week")
        trendingMoviesCollectionView.setInitialData(
            title: "Trending",
            options: [todayOption, thisWeekOption])
    }

    private func bindViews() {
        searchBarView.searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        searchBarView.searchField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)

        searchBarView.onCancelTapped = { [self] in
            searchedMoviesCollectionView.isHidden = true
            searchedMovies = []
            searchedMoviesCollectionView.reloadData()
            scrollView.isHidden = false
        }

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

        popularMoviesCollectionView
            .currentlySelectedCategory
            .map { [weak self] optionViewModel -> AnyPublisher<[MovieViewModel], Error> in
                self?.presenter.popularMovies(for: optionViewModel.id) ?? .never()
            }
            .switchToLatest()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieViewModels in
                    self?.popularMoviesCollectionView.setData(movieViewModels, animated: true)
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
                    self?.topRatedMoviesCollectionView.setData(movieViewModels, animated: true)
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
                    self?.trendingMoviesCollectionView.setData(movieViewModels, animated: true)
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
        return cell
    }

}

// MARK: CollectionViewDelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let movie = searchedMovies.at(indexPath.row) else { return }

        router.showMovieDetails(for: movie.id)
    }

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
