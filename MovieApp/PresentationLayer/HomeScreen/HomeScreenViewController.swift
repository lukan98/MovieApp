import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var searchBarView: SearchBarView!
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var popularMoviesCollectionView: CategorisedCollectionView!
    var topRatedMoviesCollectionView: CategorisedCollectionView!

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
        loadMovieGenres()
    }

    private func loadMovieGenres() {
        presenter
            .getGenres { [weak self] result in
                if case .success(let genres) = result {
                    self?.popularMoviesCollectionView.setInitialData(title: "What's Popular", genres: genres)
                    self?.topRatedMoviesCollectionView.setInitialData(title: "Top Rated", genres: genres)
                }
            }
    }

    private func bindViews() {
        popularMoviesCollectionView.onCategoryChanged = { [weak self] genreId in
            self?.loadPopularMovies(for: genreId)
        }

        topRatedMoviesCollectionView.onCategoryChanged = { [weak self] genreId in
            self?.loadTopRatedMovies(for: genreId)
        }
    }

    private func loadPopularMovies(for genreId: Int) {
        presenter.getPopularMovies(for: genreId) { [weak self] result in
            if case .success(let movies) = result {
                self?.popularMoviesCollectionView.setData(movies)
            } else {
                self?.popularMoviesCollectionView.setData([])
            }
        }

    }

    private func loadTopRatedMovies(for genreId: Int) {
        presenter.getTopRatedMovies(for: genreId) { [weak self] result in
            if case .success(let movies) = result {
                self?.topRatedMoviesCollectionView.setData(movies)
            } else {
                self?.topRatedMoviesCollectionView.setData([])
            }
        }
    }
    
}
