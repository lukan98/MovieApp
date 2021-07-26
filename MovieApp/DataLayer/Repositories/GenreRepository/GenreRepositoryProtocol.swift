protocol GenreRepositoryProtocol {

    func getGenres(
        _ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void
    )

}
