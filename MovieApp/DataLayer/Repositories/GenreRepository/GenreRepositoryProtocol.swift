import Combine

protocol GenreRepositoryProtocol {

    var genres: AnyPublisher<[GenreRepositoryModel], Error> { get }

}
