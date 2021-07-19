protocol MovieRepositoryProtocol {

    func getPopularMoviesFromNetwork(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

}
