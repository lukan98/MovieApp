protocol MovieClientProtocol {

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )
    
}
