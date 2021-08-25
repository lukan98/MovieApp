import Combine

class GenreRepository: GenreRepositoryProtocol {

    var genres: AnyPublisher<[GenreRepositoryModel], Error> {
        networkDataSource
            .genres
            .map( { $0.map { GenreRepositoryModel(from: $0) } })
            .eraseToAnyPublisher()
    }

    private let networkDataSource: GenreNetworkDataSourceProtocol

    init(networkDataSource: GenreNetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
    }

}
