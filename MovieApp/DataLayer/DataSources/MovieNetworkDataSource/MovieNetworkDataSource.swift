class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {

    private let movieClient: MovieClientProtocol

    init(movieClient: MovieClientProtocol) {
        self.movieClient = movieClient
    }

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchPopularMovies { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchTopRatedMovies { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

    func fetchTrendingMovies(
        for timeWindow: TimeWindowDataSourceModel,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchTrendingMovies(for: TimeWindowClientModel(from: timeWindow)) { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

    func fetchMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieDataSourceModel, RequestError>) -> Void
    ) {
        movieClient.fetchMovieDetails(for: movieId) { result in
            completionHandler(result.map { DetailedMovieDataSourceModel(from: $0) })
        }
    }

    func fetchMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsDataSourceModel, RequestError>) -> Void
    ) {
        movieClient.fetchMovieCredits(for: movieId) { result in
            completionHandler(result.map { CreditsDataSourceModel(from: $0) })
        }
    }

    func fetchMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchMovieReviews(for: movieId) { result in
            completionHandler(result.map { $0.results.map { ReviewDataSourceModel(from: $0) } })
        }
    }

    func fetchMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchMovieRecommendations(basedOn: movieId) { result in
            completionHandler(result.map { $0.results.map { MovieRecommendationDataSourceModel(from: $0) } })
        }
    }

    func fetchMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchMovieSearchResults(with: query) { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

}
