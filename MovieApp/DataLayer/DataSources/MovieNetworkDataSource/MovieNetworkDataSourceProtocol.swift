import Combine

protocol MovieNetworkDataSourceProtocol {

    var popularMovies: AnyPublisher<[MovieDataSourceModel], Error> { get }
    var topRatedMovies: AnyPublisher<[MovieDataSourceModel], Error> { get }

    func trendingMovies(for timeWindow: TimeWindowDataSourceModel) -> AnyPublisher<[MovieDataSourceModel], Error>
    
    func fetchMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieDataSourceModel, RequestError>) -> Void
    )

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<DetailedMovieDataSourceModel, Error>

    func fetchMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsDataSourceModel, RequestError>) -> Void
    )

    func fetchMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewDataSourceModel], RequestError>) -> Void
    )

    func fetchMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationDataSourceModel], RequestError>) -> Void
    )

    func fetchMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

}
