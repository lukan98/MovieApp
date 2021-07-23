class HomeScreenPresenter {

    private let movieUseCase: MovieUseCaseProtocol!

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }

    func fetchPopularMoviesCategorised() -> [String: [MovieViewModel]] {
        let movies = movieUseCase.getPopularMoviesCategorised()
        return movies.mapValues {
            $0.map { MovieViewModel( about: $0.about, name: $0.name, posterSource: $0.posterSource) }
        }
    }

    func fetchTrendingMoviesCategorised() -> [String: [MovieViewModel]] {
        let movies = movieUseCase.getTrendingMoviesCategorised()
        return movies.mapValues {
            $0.map { MovieViewModel( about: $0.about, name: $0.name, posterSource: $0.posterSource) }
        }
    }

    func fetchFreeToWatchMoviesCategorised() -> [String: [MovieViewModel]] {
        let movies = movieUseCase.getFreeToWatchMoviesCategorised()
        return movies.mapValues {
            $0.map { MovieViewModel( about: $0.about, name: $0.name, posterSource: $0.posterSource) }
        }
    }

}
