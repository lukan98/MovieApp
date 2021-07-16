class HomeScreenPresenter {

    private var movies: [MovieViewModel] = []
    private let movieClient: MovieClient

    var delegate: HomeScreenViewController!

    init(baseUrl: String) {
        movieClient = MovieClient(baseApiClient: BaseApiClient(baseUrl: baseUrl))
    }

    public var numberOfMovies: Int {
        movies.count
    }

    func fetchMovies() {
        movieClient.fetchPopularMovies(completionHandler: { [weak self]
            (result: Result<PopularMoviesModel, RequestError>) -> Void in
            guard let self = self else { return }

            switch result {
            case .success(let popularMovieCollection):
                self.movies = popularMovieCollection.movies.map {
                    MovieViewModel(name: $0.name, about: $0.about, posterSource: "IronMan1")
                }
            case .failure:
                print("Failed to fetch movies")
            }
        })
    }

    func getMovie(at index: Int) -> MovieViewModel? {
        movies[index]
    }

}
