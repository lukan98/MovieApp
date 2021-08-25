import Combine

class GenreClient: GenreClientProtocol {

    var genres: AnyPublisher<GenreListClientModel, Error> {
        baseApiClient
            .get(path: "/genre/movie/list")
            .eraseToAnyPublisher()
    }

    private let baseApiClient: BaseApiClient

    init(baseApiClient: BaseApiClient) {
        self.baseApiClient = baseApiClient
    }

}
