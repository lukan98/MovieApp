import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var searchBar: SearchBarView!
    var scrollView: UIScrollView!
    var stackView: UIStackView!

    private let popularTitle = "What's popular"
    private let freeToWatchTitle = "Free to Watch"
    private let trendingTitle = "Trending"

    private var popularMovieCategories: [String] = []
    private var popularMoviesByCategory: [[MovieViewModel]] = []
    private var freeToWatchMovieCategories: [String] = []
    private var freeToWatchMoviesByCategory: [[MovieViewModel]] = []
    private var trendingMovieCategories: [String] = []
    private var trendingMoviesByCategory: [[MovieViewModel]] = []
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

        fetchData()
        setData()
    }

    private func setData() {
        stackView.subviews
            .compactMap { $0 as? CategoryCollectionView }
            .forEach { categoryCollectionView in
                switch stackView.subviews.firstIndex(of: categoryCollectionView) {
                case 0:
                    categoryCollectionView.setData(
                        title: popularTitle,
                        options: popularMovieCategories,
                        movies: popularMoviesByCategory)
                case 1:
                    categoryCollectionView.setData(
                        title: freeToWatchTitle,
                        options: freeToWatchMovieCategories,
                        movies: freeToWatchMoviesByCategory)
                default:
                    categoryCollectionView.setData(
                        title: trendingTitle,
                        options: trendingMovieCategories,
                        movies: trendingMoviesByCategory)
                }
            }
    }

    private func fetchData() {
        let popularMoviesCategorised = presenter.fetchPopularMoviesCategorised()
        popularMovieCategories = popularMoviesCategorised.map { $0.key }
        popularMoviesByCategory = popularMoviesCategorised.map { $0.value }

        let trendingMoviesCategorised = presenter.fetchTrendingMoviesCategorised()
        trendingMovieCategories = trendingMoviesCategorised.map { $0.key }
        trendingMoviesByCategory = trendingMoviesCategorised.map { $0.value }

        let freeToWatchMoviesCategorised = presenter.fetchFreeToWatchMoviesCategorised()
        freeToWatchMovieCategories = freeToWatchMoviesCategorised.map { $0.key }
        freeToWatchMoviesByCategory = freeToWatchMoviesCategorised.map { $0.value }
    }

}
