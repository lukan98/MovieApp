import Foundation
import Combine

class MovieClient: MovieClientProtocol {

    private let baseApiClient: BaseApiClient

    init(baseApiClient: BaseApiClient) {
        self.baseApiClient = baseApiClient
    }

    func fetchPopularMovies(_ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void) {
        let queryParameters = [
            "language": "en-US",
            "page": "1"
        ]

        baseApiClient
            .get(
                path: "/movie/popular",
                queryParameters: queryParameters,
                completionHandler: completionHandler
            )
    }

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {
        let queryParameters = [
            "language": "en-US",
            "page": "1"
        ]

        baseApiClient
            .get(
                path: "/movie/top_rated",
                queryParameters: queryParameters,
                completionHandler: completionHandler)
    }

    func fetchTrendingMovies(
        for timeWindow: TimeWindowClientModel,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {
        let queryParameters = [
            "language": "en-US",
            "page": "1",
        ]

        baseApiClient
            .get(
                path: "/trending/movie/\(timeWindow.rawValue)",
                queryParameters: queryParameters,
                completionHandler: completionHandler)
    }

    func fetchMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieClientModel, RequestError>) -> Void
    ) {
        let queryParameters = ["language": "en-US"]

        baseApiClient
            .get(
                path: "/movie/\(movieId)",
                queryParameters: queryParameters,
                completionHandler: completionHandler)
    }

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<DetailedMovieClientModel, Error> {
        let queryParameters = ["language": "en-US"]
        return baseApiClient
            .get(
                path: "/movie/\(movieId)",
                queryParameters: queryParameters)
    }

    func fetchMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsClientModel, RequestError>) -> Void
    ) {
        baseApiClient
            .get(path: "/movie/\(movieId)/credits",
                 completionHandler: completionHandler)
    }

    func fetchMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<ReviewListClientModel, RequestError>) -> Void
    ) {
        baseApiClient
            .get(
                path: "/movie/\(movieId)/reviews",
                completionHandler: completionHandler)
    }

    func fetchMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<MovieRecommendationListClientModel, RequestError>) -> Void
    ) {
        baseApiClient
            .get(
                path: "/movie/\(movieId)/recommendations",
                completionHandler: completionHandler)
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
