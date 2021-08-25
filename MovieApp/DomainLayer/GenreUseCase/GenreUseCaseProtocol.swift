import Combine

protocol GenreUseCaseProtocol {

    var genres: AnyPublisher<[GenreModel], Error> { get }

    func getGenres(_ completionHandler: @escaping (Result<[GenreModel], RequestError>) -> Void)

}
