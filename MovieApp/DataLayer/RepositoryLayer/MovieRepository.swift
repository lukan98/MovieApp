class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: NetworkDataSourceProtocol
    private var storedPopularMovies: [MovieRepositoryModel]

    init(networkDataSource: NetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.storedPopularMovies = []
    }

    private func getPopularMoviesFromNetwork(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchPopularMovies { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let dataSourceMovies):
                let repositoryMovies = dataSourceMovies.map { MovieRepositoryModel(from: $0) }
                self.storedPopularMovies = repositoryMovies
                completionHandler(.success(repositoryMovies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func getPopularMoviesFromLocal(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        if !storedPopularMovies.isEmpty {
            completionHandler(.success(storedPopularMovies))
        } else {
            completionHandler(.failure(RequestError.noDataError))
        }
    }

    func getPopularMovies(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        getPopularMoviesFromLocal { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let localMovies):
                completionHandler(.success(localMovies))
            case .failure:
                self.getPopularMoviesFromNetwork { result in
                    switch result {
                    case .success(let remoteMovies):
                        completionHandler(.success(remoteMovies))
                    case .failure(let remoteError):
                        completionHandler(.failure(remoteError))
                    }
                }
            }
        }
    }
}
