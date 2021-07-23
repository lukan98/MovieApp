class MovieUseCase: MovieUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void) {
        movieRepository.getPopularMovies { result in
            switch result {
            case .success(let repositoryMovies):
                let movies = repositoryMovies.map { MovieModel(from: $0) }
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func getPopularMoviesCategorised() -> [String : [MovieModel]] {
        MockData.popularData
    }

    func getTrendingMoviesCategorised() -> [String : [MovieModel]] {
        MockData.trendingData
    }

    func getFreeToWatchMoviesCategorised() -> [String : [MovieModel]] {
        MockData.freeToWatch
    }

}
