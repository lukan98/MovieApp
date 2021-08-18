class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: MovieNetworkDataSourceProtocol
    private let localMetadataSource: MovieLocalMetadataSourceProtocol
    
    private var storedPopularMovies: [MovieRepositoryModel]
    private var storedTopRatedMovies: [MovieRepositoryModel]
    private var storedTrendingMovies: [TimeWindowRepositoryModel: [MovieRepositoryModel]]

    var favoriteMovies: [Int] {
        localMetadataSource.favorites
    }

    init(
        networkDataSource: MovieNetworkDataSourceProtocol,
        localMetadataSource: MovieLocalMetadataSourceProtocol
    ) {
        self.networkDataSource = networkDataSource
        self.localMetadataSource = localMetadataSource
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
            case .success(let movieRepositoryModels):
                completionHandler(.success(movieRepositoryModels))
            case .failure:
                self.getPopularMoviesFromNetwork { result in
                    switch result {
                    case .success(let movieRepositoryModels):
                        completionHandler(.success(movieRepositoryModels))
                    case .failure(let error):
                        completionHandler(.failure(error))
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
        localMetadataSource.toggleFavorited(for: movieId)
        let favorites = localMetadataSource.favorites
        updateMovieLists(favoritedMovies: favorites)
    }

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieRepositoryModel, RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieDetails(for: movieId) { result in
            completionHandler(result.map { [weak self] in
                guard let self = self else {
                    return DetailedMovieRepositoryModel(from: $0)
                }

                let isFavorited = self.favoriteMovies.contains($0.id)
                return DetailedMovieRepositoryModel(from: $0, isFavorited: isFavorited)
            })
        }
    }

    func getMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsRepositoryModel, RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieCredits(for: movieId) { result in
            completionHandler(result.map { CreditsRepositoryModel(from: $0) })
        }
    }

    func getMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieReviews(for: movieId) { result in
            completionHandler(result.map { $0.map { ReviewRepositoryModel(from: $0) } })
        }
    }

    func getMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieRecommendations(basedOn: movieId) { result in
            completionHandler(result.map { $0.map { MovieRecommendationRepositoryModel(from: $0) } })
        }
    }

    func getMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieSearchResults(with: query) { result in
            completionHandler(result.map { $0.map { MovieRepositoryModel(from: $0) } })
        }
    }

    private func updateMovieLists(favoritedMovies: [Int]) {
        let updatingFunction: (MovieRepositoryModel) -> MovieRepositoryModel = { movie in
            let isFavorited = favoritedMovies.contains(movie.id)
            return movie.withFavorited(isFavorited)
        }
        storedPopularMovies = storedPopularMovies.map { updatingFunction($0) }
        storedTopRatedMovies = storedTopRatedMovies.map { updatingFunction($0) }
        for (key, value) in storedTrendingMovies {
            storedTrendingMovies[key] = value.map { updatingFunction($0) }
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
                let favorites = self.localMetadataSource.favorites
                self.updateMovieLists(favoritedMovies: favorites)
                self.getPopularMoviesFromLocal(completionHandler)
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
                let favorites = self.localMetadataSource.favorites
                self.updateMovieLists(favoritedMovies: favorites)
                self.getTopRatedMoviesFromLocal(completionHandler)
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

            let mappedResult = result.map { $0.map { MovieRepositoryModel(from: $0) } }
            switch mappedResult {
            case .success(let repositoryMovieModels):
                self.storedTrendingMovies[timeWindow] = repositoryMovieModels
                let favorites = self.localMetadataSource.favorites
                self.updateMovieLists(favoritedMovies: favorites)
                self.getTrendingMoviesFromLocal(for: timeWindow, completionHandler)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
