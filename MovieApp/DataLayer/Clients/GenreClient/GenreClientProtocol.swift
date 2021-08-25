import Combine

protocol GenreClientProtocol {

    var genres: AnyPublisher<GenreListClientModel, Error> { get }

}
