import Combine

protocol MovieClientProtocol {

    var popularMovies: AnyPublisher<MovieListClientModel, Error> { get }
    var topRatedMovies: AnyPublisher<MovieListClientModel, Error> { get }

    func trendingMovies(for timeWindow: TimeWindowClientModel) -> AnyPublisher<MovieListClientModel, Error>

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieClientModel, Error>

    func credits(for movieId: Int) -> AnyPublisher<CreditsClientModel, Error>

    func fetchMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<ReviewListClientModel, RequestError>) -> Void
    )

    func fetchMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<MovieRecommendationListClientModel, RequestError>) -> Void
    )

    func fetchMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )
}
