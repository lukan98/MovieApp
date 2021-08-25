import Combine

protocol GenreRepositoryProtocol {

    var genres: AnyPublisher<[GenreRepositoryModel], Error> { get }

    func getGenres(
        _ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void
    )

}
