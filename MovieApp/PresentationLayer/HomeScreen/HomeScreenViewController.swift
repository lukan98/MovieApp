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
        loadMovieOptions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barStyle = .black
        reloadData()
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

    private func loadMovieOptions() {
        presenter
            .getGenres { [weak self] result in
                guard let self = self else { return }

                if case .success(let genres) = result {
                    self.popularMoviesCollectionView.setInitialData(
                        title: "What's Popular",
                        options: genres.map { OptionViewModel(from: $0) })
                    self.topRatedMoviesCollectionView.setInitialData(
                        title: "Top Rated",
                        options: genres.map { OptionViewModel(from: $0) })
                }
            }

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

        popularMoviesCollectionView.onCategoryChanged = { [weak self] optionId in
            guard let self = self else { return }

            self.presenter
                .popularMovies(for: optionId)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { movies in
                        self.popularMoviesCollectionView.setData(movies, animated: true)
                    })
                .store(in: &self.disposables)
        }

        topRatedMoviesCollectionView.onCategoryChanged = { [weak self] optionId in
            self?.loadTopRatedMovies(for: optionId)
        }

        trendingMoviesCollectionView.onCategoryChanged = { [weak self] optionId in
            self?.loadTrendingMovies(for: optionId)
        }

        popularMoviesCollectionView.onMovieFavorited = toggleFavorited
        topRatedMoviesCollectionView.onMovieFavorited = toggleFavorited
        trendingMoviesCollectionView.onMovieFavorited = toggleFavorited

        popularMoviesCollectionView.onMovieSelected = selectedMovie
        topRatedMoviesCollectionView.onMovieSelected = selectedMovie
        trendingMoviesCollectionView.onMovieSelected = selectedMovie
    }

    private func loadTopRatedMovies(for optionId: Int, animated: Bool = true) {
        presenter.getTopRatedMovies(for: optionId) { [weak self] result in
            if case .success(let movies) = result {
                self?.topRatedMoviesCollectionView.setData(movies, animated: animated)
            } else {
                self?.topRatedMoviesCollectionView.setData([], animated: animated)
            }
        }
    }

    private func loadTrendingMovies(for optionId: Int, animated: Bool = true) {
        guard let timeWindow = TimeWindowViewModel(rawValue: optionId) else { return }

        presenter.getTrendingMovies(for: timeWindow) { [weak self] result in
            if case .success(let movies) = result {
                self?.trendingMoviesCollectionView.setData(movies, animated: animated)
            } else {
                self?.trendingMoviesCollectionView.setData([], animated: animated)
            }
        }
    }

    private func selectedMovie(with movieId: Int) {
        router.showMovieDetails(for: movieId)
    }

    private func toggleFavorited(for movieId: Int) {
        presenter.toggleFavorited(for: movieId) { self.reloadData() }
    }

    private func reloadData() {
        guard
            let topRatedOption = topRatedMoviesCollectionView.currentlySelectedCategory,
            let trendingOption = trendingMoviesCollectionView.currentlySelectedCategory
        else {
            return
        }

        loadTopRatedMovies(
            for: topRatedOption.id,
            animated: false)
        loadTrendingMovies(
            for: trendingOption.id,
            animated: false)
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
