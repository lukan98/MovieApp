class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: MovieNetworkDataSourceProtocol
    
    private var storedPopularMovies: [MovieRepositoryModel]
    private var storedTopRatedMovies: [MovieRepositoryModel]

    init(networkDataSource: MovieNetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.storedPopularMovies = []
        self.storedTopRatedMovies = []
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

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        getPopularMovies { result in
            switch result {
            case .success(let movieRepositoryModels):
                let filteredMovieRepositoryModels = movieRepositoryModels.filter { $0.genres.contains(genreId) }
                completionHandler(.success(filteredMovieRepositoryModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        getTopRatedMovies { result in
            switch result {
            case .success(let movieRepositoryModels):
                let filteredMovieRepositoryModels = movieRepositoryModels.filter { $0.genres.contains(genreId) }
                completionHandler(.success(filteredMovieRepositoryModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }

        }
    }

    func getTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        var keyString: String
        if timeWindowId == 1 {
            keyString = "week"
        } else {
            keyString = "day"
        }

        if let trendingMovies = MockMovieData.trendingData[keyString] {
            completionHandler(.success(trendingMovies))
        } else {
            completionHandler(.failure(.noDataError))
        }
    }

    private func getPopularMoviesFromNetwork(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchPopularMovies { [weak self] result in
            guard let self = self else { return }

            let mappedResult = result.map { $0.map { MovieRepositoryModel(from: $0) } }
            switch mappedResult {
            case .success(let repositoryMovieModels):
                self.storedPopularMovies = repositoryMovieModels
                completionHandler(.success(repositoryMovieModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func getPopularMoviesFromLocal(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        if storedPopularMovies.isEmpty {
            completionHandler(.failure(.noDataError))
        } else {
            completionHandler(.success(storedPopularMovies))
        }
    }

    private func getTopRatedMovies(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        getTopRatedMoviesFromLocal { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let repositoryMovieModels):
                completionHandler(.success(repositoryMovieModels))
            case .failure:
                self.getTopRatedMoviesFromNetwork { result in
                    switch result {
                    case .success(let repositoryMovieModels):
                        completionHandler(.success(repositoryMovieModels))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            }

        }
    }

    private func getTopRatedMoviesFromLocal(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        if storedTopRatedMovies.isEmpty {
            completionHandler(.failure(.noDataError))
        } else {
            completionHandler(.success(storedTopRatedMovies))
        }
    }

    private func getTopRatedMoviesFromNetwork(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchTopRatedMovies { [weak self] result in
            guard let self = self else { return }

            let mappedResult = result.map { $0.map { MovieRepositoryModel(from: $0) } }
            switch mappedResult {
            case .success(let repositoryMovieModels):
                self.storedTopRatedMovies = repositoryMovieModels
                completionHandler(.success(repositoryMovieModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
