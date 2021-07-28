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

    func fetchPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {
        fetchPopularMovies { result in
            switch result {
            case .success(let movieListModel):
                print(movieListModel.movies)
                completionHandler(.success(movieListModel))
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }

    func fetchTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {
        
    }

    func fetchTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {

    }

    private func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    ) {

    }

}
