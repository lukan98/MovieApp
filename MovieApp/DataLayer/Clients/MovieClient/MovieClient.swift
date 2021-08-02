import Foundation

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
                path: "/trending/movie/" + timeWindow.rawValue,
                queryParameters: queryParameters,
                completionHandler: completionHandler)
    }

    func fetchMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieClientModel, RequestError>) -> Void
    ) {
        let queryParameters = ["language": "en-US"]

        baseApiClient
            .get(path: "/movie/" + String(movieId),
                 queryParameters: queryParameters,
                 completionHandler: completionHandler)
    }

}
