protocol MovieNetworkDataSourceProtocol {

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

    func fetchPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

    func fetchTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

    func fetchTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

}
