import Foundation

class MovieClient: MovieClientProtocol {

    private let baseApiClient: BaseApiClient

    init(baseApiClient: BaseApiClient) {
        self.baseApiClient = baseApiClient
    }

    func fetchPopularMovies(completionHandler: @escaping (Result<PopularMoviesModel, RequestError>) -> Void) {
        let queryParameters = [
            "language": "en-US",
            "page": "1",
            "api_key": baseApiClient.apiKey
        ]

        baseApiClient
            .get(
                path: "/movie/popular",
                queryParameters: queryParameters,
                completionHandler: completionHandler
            )
    }

}
