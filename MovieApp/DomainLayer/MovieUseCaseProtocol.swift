protocol MovieUseCaseProtocol {

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void)

}
