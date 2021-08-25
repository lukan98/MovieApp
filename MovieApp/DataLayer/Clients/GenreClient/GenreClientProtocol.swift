import Combine

protocol GenreClientProtocol {

    var genres: AnyPublisher<GenreListClientModel, Error> { get }

    func fetchGenres(_ completionHandler: @escaping (Result<GenreListClientModel, RequestError>) -> Void)

}
