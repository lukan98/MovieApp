class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: NetworkDataSourceProtocol

    init(networkDataSource: NetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
    }

    func getPopularMoviesFromNetwork(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchPopularMovies { result in
            switch result {
            case .success(let dataSourceMovies):
                let repositoryMovies = dataSourceMovies.map { MovieRepositoryModel(from: $0) }
                completionHandler(.success(repositoryMovies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
