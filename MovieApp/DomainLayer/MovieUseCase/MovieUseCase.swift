import Foundation
import Combine

class MovieUseCase: MovieUseCaseProtocol {

    private let queue = DispatchQueue(label: "movie.queue", qos: .background)
    private let movieRepository: MovieRepositoryProtocol

    private var disposables = Set<AnyCancellable>()

    var favoriteMovies: AnyPublisher<[DetailedMovieModel], Error> {
        movieRepository
            .favoriteMoviesPublisher
            .map { $0.map { DetailedMovieModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    var popularMovies: AnyPublisher<[MovieModel], Error> {
        movieRepository
            .popularMovies
            .map { $0.map { MovieModel(from: $0) } }
            .eraseToAnyPublisher()
    }

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

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error> {
        movieRepository
            .popularMovies(for: genreId)
            .map { $0.map { MovieModel(from: $0) } }
            .eraseToAnyPublisher()
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
        for timeWindow: TimeWindowModel,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    ) {
        movieRepository.getTrendingMovies(for: timeWindow.toRepoModel()) { result in
            completionHandler(result.map { $0.map { MovieModel(from: $0) } })
        }
    }

    func toggleFavorited(for movieId: Int) {
        movieRepository.toggleFavorited(for: movieId)
    }

    func getFavoriteMovies(_ completionHandler: @escaping (Result<[DetailedMovieModel], RequestError>) -> Void) {
        let favoriteMovieIds = movieRepository.favoriteMovies

        var finished = 0
        var movies: [DetailedMovieRepositoryModel] = []

        let handler: (Result<DetailedMovieRepositoryModel, RequestError>) -> Void = { [weak self] result in
            guard let self = self else { return }

            self.queue.sync {
                switch result {
                case .success(let movie):
                    movies.append(movie)
                default:
                    break
                }

                finished += 1

                if finished == favoriteMovieIds.count {
                    completionHandler(.success(movies.map { DetailedMovieModel(from: $0) }))
                }
            }
        }

        favoriteMovieIds.forEach { id in
            movieRepository.getMovieDetails(for: id, handler)
        }
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
