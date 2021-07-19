class MovieUseCase: MovieUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    func getRemotePopularMovies(_ completionHandler: @escaping (Result<[Movie], RequestError>) -> Void) {
        movieRepository.getPopularMoviesFromNetwork { result in
            switch result {
            case .success(let repositoryMovies):
                let movies = repositoryMovies.map { Movie(from: $0) }
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
