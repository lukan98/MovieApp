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
                    let posterSource = "https://image.tmdb.org/t/p/w185"+$0.posterSource
                    return MovieViewModel(name: $0.name, about: $0.about, posterSource: posterSource)
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
