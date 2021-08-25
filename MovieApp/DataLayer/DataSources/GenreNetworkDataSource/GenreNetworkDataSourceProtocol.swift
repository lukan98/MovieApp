import Combine

protocol GenreNetworkDataSourceProtocol {

    var genres: AnyPublisher<[GenreDataSourceModel], Error> { get }

    func fetchGenres(
        _ completionHandler: @escaping (Result<[GenreDataSourceModel], RequestError>) -> Void
    )

}
