import Combine
import Foundation

class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {

    private let movieClient: MovieClientProtocol

    var popularMovies: AnyPublisher<[MovieDataSourceModel], Error> {
        movieClient
            .popularMovies
            .map { $0.movies.map { MovieDataSourceModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    var topRatedMovies: AnyPublisher<[MovieDataSourceModel], Error> {
        movieClient
            .topRatedMovies
            .map { $0.movies.map { MovieDataSourceModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    init(movieClient: MovieClientProtocol) {
        self.movieClient = movieClient
    }

    func trendingMovies(for timeWindow: TimeWindowDataSourceModel) -> AnyPublisher<[MovieDataSourceModel], Error> {
        movieClient
            .trendingMovies(for: timeWindow.toClientModel())
            .map { $0.movies.map { MovieDataSourceModel(from: $0)}}
            .eraseToAnyPublisher()
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieDataSourceModel, Error> {
        movieClient
            .details(for: movieId)
            .map { DetailedMovieDataSourceModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func credits(for movieId: Int) -> AnyPublisher<CreditsDataSourceModel, Error> {
        movieClient
            .credits(for: movieId)
            .map { CreditsDataSourceModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewDataSourceModel], Error> {
        movieClient
            .reviews(for: movieId)
            .map { $0.results.map { ReviewDataSourceModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func recommendations(basedOn movieId: Int) -> AnyPublisher<[MovieRecommendationDataSourceModel], Error> {
        movieClient
            .recommendations(basedOn: movieId)
            .map { $0.results.map { MovieRecommendationDataSourceModel(from: $0) } }
            .eraseToAnyPublisher()
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
