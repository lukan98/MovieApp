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

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieModel, RequestError>) -> Void
    ) {
        movieRepository.getMovieDetails(for: movieId) { result in
            completionHandler(result.map { DetailedMovieModel(from: $0) })
        }
    }

    func getMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsModel, RequestError>) -> Void
    ) {
        movieRepository.getMovieCredits(for: movieId) { result in
            completionHandler(result.map { CreditsModel(from: $0) })
        }
    }

    func getMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewModel], RequestError>) -> Void
    ) {
        movieRepository.getMovieReviews(for: movieId) { result in
            completionHandler(result.map { $0.map { ReviewModel(from: $0) } })
        }
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
