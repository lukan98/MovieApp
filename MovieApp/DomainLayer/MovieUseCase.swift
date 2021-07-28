class MovieUseCase: MovieUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        movieRepository.getPopularMovies { result in
            completionHandler(result.map { $0.map { MovieModel(from: $0) } })
        }
    }

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    ) {
        movieRepository.getPopularMovies(for: genreId) { result in
            completionHandler(result.map { $0.map { MovieModel(from: $0) } })
        }
    }

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    ) {
        movieRepository.getTopRatedMovies(for: genreId) { result in
            completionHandler(result.map { $0.map { MovieModel(from: $0) } })
        }
    }

    func getTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    ) {
        movieRepository.getTrendingMovies(for: timeWindowId) { result in
            completionHandler(result.map { $0.map { MovieModel(from: $0) } })
        }
    }
}
