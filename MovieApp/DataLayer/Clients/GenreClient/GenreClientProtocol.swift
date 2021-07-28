protocol GenreClientProtocol {

    func fetchGenres(_ completionHandler: @escaping (Result<GenreListClientModel, RequestError>) -> Void)

}
