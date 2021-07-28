protocol MovieClientProtocol {

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTrendingMovies(
        for timeWindow: TimeWindow,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )
    
}
