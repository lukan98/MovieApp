import Combine

protocol MovieNetworkDataSourceProtocol {

    var popularMovies: AnyPublisher<[MovieDataSourceModel], Error> { get }
    var topRatedMovies: AnyPublisher<[MovieDataSourceModel], Error> { get }

    func trendingMovies(for timeWindow: TimeWindowDataSourceModel) -> AnyPublisher<[MovieDataSourceModel], Error>

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieDataSourceModel, Error>

    func credits(for movieId: Int) -> AnyPublisher<CreditsDataSourceModel, Error>

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewDataSourceModel], Error>

    func fetchMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationDataSourceModel], RequestError>) -> Void
    )

    func fetchMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

}
