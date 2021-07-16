class HomeScreenPresenter {

    private let movieClient: MovieClient

    init(movieClient: MovieClient) {
        self.movieClient = movieClient
    }

    func fetchMovies(_ completion: @escaping (Result<[MovieViewModel], Error>) -> Void) {
        movieClient.fetchPopularMovies { result in
            switch result {
            case .success(let popularMovieCollection):
                let movies: [MovieViewModel] = popularMovieCollection.movies.map {
                    let posterSource = "https://image.tmdb.org/t/p/w185" + $0.posterSource
                    return MovieViewModel(name: $0.name, about: $0.about, posterSource: posterSource)
                }
                completion(.success(movies))
            case .failure:
                print("Failed to fetch movies")
            }
        }
    }
}
