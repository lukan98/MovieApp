class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: MovieNetworkDataSourceProtocol

    private var favoriteMovies = MockedFavorites.favorites {
        didSet {
            print(favoriteMovies)
        }
    }

    private var storedPopularMovies: [MovieRepositoryModel]
    private var storedTopRatedMovies: [MovieRepositoryModel]
    private var storedTrendingMovies: [TimeWindowRepositoryModel: [MovieRepositoryModel]]

    private var storedMovies: [MovieRepositoryModel] {
        var movies = storedPopularMovies
        movies.append(contentsOf: storedTopRatedMovies)
        for (_, value) in storedTrendingMovies {
            movies.append(contentsOf: value)
        }
        return movies
    }

    init(networkDataSource: MovieNetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.storedPopularMovies = []
        self.storedTopRatedMovies = []
        self.storedTrendingMovies = [:]
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
        for timeWindow: TimeWindowRepositoryModel,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        getTrendingMoviesFromLocal(for: timeWindow) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let repositoryMovieModels):
                completionHandler(.success(repositoryMovieModels))
            case .failure:
                self.getTrendingMoviesFromNetwork(for: timeWindow) { result in
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

    func toggleFavorited(for movieId: Int) {
        let isFavorited = favoriteMovies.contains(movieId)
        if isFavorited {
            favoriteMovies.removeAll { $0 == movieId }
        } else {
            favoriteMovies.append(movieId)
        }
        toggleMovieFavorited(movieId)
    }

    private func toggleMovieFavorited(_ movieId: Int) {
        storedPopularMovies = storedPopularMovies.map { movie in
            if movie.id == movieId {
                return MovieRepositoryModel(from: movie, isFavorited: !movie.isFavorited)
            } else {
                return MovieRepositoryModel(from: movie, isFavorited: movie.isFavorited)
            }
        }

        storedTopRatedMovies = storedTopRatedMovies.map { movie in
            if movie.id == movieId {
                return MovieRepositoryModel(from: movie, isFavorited: !movie.isFavorited)
            } else {
                return MovieRepositoryModel(from: movie, isFavorited: movie.isFavorited)
            }
        }
    }

    private func getPopularMoviesFromNetwork(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchPopularMovies { [weak self] result in
            guard let self = self else { return }

            let mappedResult = result.map { $0.map { self.labelFavoriteMovie($0) } }
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

            let mappedResult = result.map { $0.map { self.labelFavoriteMovie($0) } }
            switch mappedResult {
            case .success(let repositoryMovieModels):
                self.storedTopRatedMovies = repositoryMovieModels
                completionHandler(.success(repositoryMovieModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func getTrendingMoviesFromLocal(
        for timeWindow: TimeWindowRepositoryModel,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        if let storedTrendingMovies = storedTrendingMovies[timeWindow] {
            completionHandler(.success(storedTrendingMovies))
        } else {
            completionHandler(.failure(.noDataError))
        }
    }

    private func getTrendingMoviesFromNetwork(
        for timeWindow: TimeWindowRepositoryModel,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchTrendingMovies(for: timeWindow.toDataSourceModel()) { [weak self] result in
            guard let self = self else { return }

            let mappedResult = result.map { $0.map { self.labelFavoriteMovie($0) } }
            switch mappedResult {
            case .success(let repositoryMovieModels):
                self.storedTrendingMovies[timeWindow] = repositoryMovieModels
                completionHandler(.success(repositoryMovieModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func labelFavoriteMovie(_ movie: MovieDataSourceModel) -> MovieRepositoryModel {
        let isFavorited = favoriteMovies.contains(movie.id)
        return MovieRepositoryModel(from: movie, isFavorited: isFavorited)
    }

}
