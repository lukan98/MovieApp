class MovieListPresenter {

    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }

    func fetchMovies(_ completionHandler: @escaping (Result<[MovieViewModel], Error>) -> Void) {
        movieUseCase.getPopularMovies { result in
            switch result {
            case .success(let movies):
                let movieViewModels = movies.map { MovieViewModel(from: $0) }
                completionHandler(.success(movieViewModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
