protocol MovieRepositoryProtocol {

    func getPopularMovies(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

}
