import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var searchBarView: SearchBarView!
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var popularMoviesCollectionView: CategorisedCollectionView!
    var topRatedMoviesCollectionView: CategorisedCollectionView!
    var trendingMoviesCollectionView: CategorisedCollectionView!

    private var presenter: HomeScreenPresenter!

    init(presenter: HomeScreenPresenter) {
        super.init(nibName: nil, bundle: nil)

        self.presenter = presenter
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

    private func loadMovieOptions() {
        presenter
            .getGenres { [weak self] result in
                if case .success(let genres) = result {
                    self?.popularMoviesCollectionView.setInitialData(
                        title: "What's Popular",
                        options: genres.map { OptionViewModel(from: $0) })
                    self?.topRatedMoviesCollectionView.setInitialData(
                        title: "Top Rated",
                        options: genres.map { OptionViewModel(from: $0) })
                }
            }

        let todayOption = OptionViewModel(id: 0, name: "Today")
        let thisWeekOption = OptionViewModel(id: 1, name: "This Week")
        trendingMoviesCollectionView.setInitialData(title: "Trending", options: [todayOption, thisWeekOption])
    }

    private func bindViews() {
        popularMoviesCollectionView.onCategoryChanged = { [weak self] optionId in
            self?.loadPopularMovies(for: optionId)
        }

        topRatedMoviesCollectionView.onCategoryChanged = { [weak self] optionId in
            self?.loadTopRatedMovies(for: optionId)
        }

        trendingMoviesCollectionView.onCategoryChanged = { [weak self] optionId in
            self?.loadTrendingMovies(for: optionId)
        }
    }

    private func loadPopularMovies(for optionId: Int) {
        presenter.getPopularMovies(for: optionId) { [weak self] result in
            if case .success(let movies) = result {
                self?.popularMoviesCollectionView.setData(movies)
            } else {
                self?.popularMoviesCollectionView.setData([])
            }
        }

    }

    private func loadTopRatedMovies(for optionId: Int) {
        presenter.getTopRatedMovies(for: optionId) { [weak self] result in
            if case .success(let movies) = result {
                self?.topRatedMoviesCollectionView.setData(movies)
            } else {
                self?.topRatedMoviesCollectionView.setData([])
            }
        }
    }

    private func loadTrendingMovies(for optionId: Int) {
        presenter.getTrendingMovies(for: optionId) { [weak self] result in
            if case .success(let movies) = result {
                self?.trendingMoviesCollectionView.setData(movies)
            } else {
                self?.trendingMoviesCollectionView.setData([])
            }
        }
    }
    
}
