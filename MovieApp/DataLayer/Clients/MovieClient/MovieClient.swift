import Foundation
import Combine

class MovieClient: MovieClientProtocol {

    private let baseApiClient: BaseApiClient

    var popularMovies: AnyPublisher<MovieListClientModel, Error> {
        let queryParameters = [
            "language": "en-US",
            "page": "1"
        ]

        return baseApiClient
            .get(
                path: "/movie/popular",
                queryParameters: queryParameters)
    }

    var topRatedMovies: AnyPublisher<MovieListClientModel, Error> {
        let queryParameters = [
            "language": "en-US",
            "page": "1"
        ]

        return baseApiClient
            .get(
                path: "/movie/top_rated",
                queryParameters: queryParameters)
    }

    init(baseApiClient: BaseApiClient) {
        self.baseApiClient = baseApiClient
    }

    func trendingMovies(for timeWindow: TimeWindowClientModel) -> AnyPublisher<MovieListClientModel, Error> {
        let queryParameters = [
            "language": "en-US",
            "page": "1"
        ]

        return baseApiClient
            .get(path: "/trending/movie/\(timeWindow.rawValue)",
                 queryParameters: queryParameters)
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieClientModel, Error> {
        let queryParameters = ["language": "en-US"]
        return baseApiClient
            .get(
                path: "/movie/\(movieId)",
                queryParameters: queryParameters)
    }

    func credits(for movieId: Int) -> AnyPublisher<CreditsClientModel, Error> {
        baseApiClient
            .get(path: "/movie/\(movieId)/credits")
    }

    func reviews(for movieId: Int) -> AnyPublisher<ReviewListClientModel, Error> {
        baseApiClient
            .get(path: "/movie/\(movieId)/reviews")
    }

    func recommendations(basedOn movieId: Int) -> AnyPublisher<MovieRecommendationListClientModel, Error> {
        baseApiClient
            .get(path: "/movie/\(movieId)/recommendations")
    }

    func fetchMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {
        let queryParameters = [
            "query": query
        ]

        baseApiClient
            .get(path: "/search/movie",
                 queryParameters: queryParameters,
                 completionHandler: completionHandler)
    }

}
