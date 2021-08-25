import Combine

protocol GenreUseCaseProtocol {

    var genres: AnyPublisher<[GenreModel], Error> { get }

}
