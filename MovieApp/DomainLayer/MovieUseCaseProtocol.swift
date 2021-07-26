protocol MovieUseCaseProtocol {

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void)

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

}
