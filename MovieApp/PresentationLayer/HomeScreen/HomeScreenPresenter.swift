class HomeScreenPresenter {

    private let movieUseCase: MovieUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol, genreUseCase: GenreUseCaseProtocol) {
        self.movieUseCase = movieUseCase
        self.genreUseCase = genreUseCase
    }

    func getGenres(_ completionHandler: @escaping (Result<[GenreViewModel], RequestError>) -> Void) {
        genreUseCase.getGenres { result in
            completionHandler(result.map { $0.map { GenreViewModel(from: $0) } })
        }
    }

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        movieUseCase.getPopularMovies(for: genreId) { result in
            completionHandler(result.map { $0.map { MovieViewModel(from: $0) } })
        }
    }
}
