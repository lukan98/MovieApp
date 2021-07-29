protocol MovieClientProtocol {

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTrendingMovies(
        for timeWindow: TimeWindowClientModel,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )
    
}
