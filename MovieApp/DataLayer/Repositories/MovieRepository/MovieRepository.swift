class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: MovieNetworkDataSourceProtocol
    
    private var storedPopularMovies: [MovieRepositoryModel]

    init(networkDataSource: MovieNetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.storedPopularMovies = []
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
//        let popularMovies = MockMovieData.popularData
//        let popularMoviesForGenre = popularMovies.filter { $0.genres.contains(genreId) }
//        if popularMoviesForGenre.isEmpty {
//            completionHandler(.failure(.noDataError))
//        } else {
//            completionHandler(.success(popularMoviesForGenre))
//        }
    }

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        let topRatedMovies = MockMovieData.topRatedData
        let topRatedMoviesForGenre = topRatedMovies.filter { $0.genres.contains(genreId) }
        if topRatedMoviesForGenre.isEmpty {
            completionHandler(.failure(.noDataError))
        } else {
            completionHandler(.success(topRatedMoviesForGenre))
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
        if storedPopularMovies.isEmpty {
            completionHandler(.failure(.noDataError))
        } else {
            completionHandler(.success(storedPopularMovies))
        }
    }
}
