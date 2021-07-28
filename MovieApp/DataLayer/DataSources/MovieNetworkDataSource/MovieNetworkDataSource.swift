class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {

    private let movieClient: MovieClientProtocol

    init(movieClient: MovieClientProtocol) {
        self.movieClient = movieClient
    }

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchPopularMovies { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchTopRatedMovies { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

    func fetchTrendingMovies(
        for timeWindow: TimeWindow,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchTrendingMovies(for: timeWindow) { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

}
