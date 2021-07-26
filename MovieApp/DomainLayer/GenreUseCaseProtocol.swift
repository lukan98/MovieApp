protocol GenreUseCaseProtocol {

    func getGenres(_ completionHandler: @escaping (Result<[GenreModel], RequestError>) -> Void)

}
