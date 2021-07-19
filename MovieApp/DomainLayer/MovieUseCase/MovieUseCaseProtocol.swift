protocol MovieUseCaseProtocol {

    func getRemotePopularMovies(_ completionHandler: @escaping (Result<[Movie], RequestError>) -> Void)

}
