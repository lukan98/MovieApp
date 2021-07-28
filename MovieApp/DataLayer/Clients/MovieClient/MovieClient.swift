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
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {

    }

}
