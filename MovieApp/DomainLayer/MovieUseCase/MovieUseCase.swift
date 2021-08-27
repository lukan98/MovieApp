import Foundation
import Combine

class MovieUseCase: MovieUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol

    private var disposables = Set<AnyCancellable>()

    var favoriteMovies: AnyPublisher<[DetailedMovieModel], Error> {
        movieRepository
            .favoriteMovies
            .map { $0.map { DetailedMovieModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error> {
        movieRepository
            .popularMovies(for: genreId)
            .map { $0.map { MovieModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func topRatedMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error> {
        movieRepository
            .topRatedMovies(for: genreId)
            .map { $0.map { MovieModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func trendingMovies(for timeWindow: TimeWindowModel) -> AnyPublisher<[MovieModel], Error> {
        movieRepository
            .trendingMovies(for: timeWindow.toRepoModel())
            .map { $0.map { MovieModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func toggleFavorited(for movieId: Int) {
        movieRepository.toggleFavorited(for: movieId)
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieModel, Error> {
        movieRepository
            .details(for: movieId)
            .map { DetailedMovieModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func credits(for movieId: Int) -> AnyPublisher<CreditsModel, Error> {
        movieRepository
            .credits(for: movieId)
            .map { CreditsModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewModel], Error> {
        movieRepository
            .reviews(for: movieId)
            .map { $0.map { ReviewModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func recommendations(basedOn movieId: Int) -> AnyPublisher<[MovieRecommendationModel], Error> {
        movieRepository
            .recommendations(basedOn: movieId)
            .map { $0.map { MovieRecommendationModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func getMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationModel], RequestError>) -> Void
    ) {
        movieRepository.getMovieRecommendations(basedOn: movieId) { result in
            completionHandler(result.map { $0.map { MovieRecommendationModel(from: $0) } })
        }
    }

    func getMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    ) {
        movieRepository.getMovieSearchResults(with: query) { result in
            completionHandler(result.map { $0.map { MovieModel(from: $0) } })
        }
    }

}
