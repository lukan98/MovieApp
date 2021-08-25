import Combine

protocol GenreNetworkDataSourceProtocol {

    var genres: AnyPublisher<[GenreDataSourceModel], Error> { get }

}
