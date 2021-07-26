protocol MovieRepositoryProtocol {

    func getPopularMovies(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

}
