protocol MovieUseCaseProtocol {

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void)

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

    func getTrendingMovies(
        for timeWindow: TimeWindow,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

}
