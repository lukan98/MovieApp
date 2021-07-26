class GenreRepository: GenreRepositoryProtocol {

    func getGenres(_ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void) {
        getGenresFromLocal(completionHandler)
    }

    private func getGenresFromLocal(
        _ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void
    ) {
        if MockGenreData.genres.isEmpty {
            completionHandler(.failure(.noDataError))
        } else {
            completionHandler(.success(MockGenreData.genres))
        }
    }

}
