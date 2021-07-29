protocol MovieNetworkDataSourceProtocol {

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

    func fetchTrendingMovies(
        for timeWindow: TimeWindowDataSourceModel,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

}
