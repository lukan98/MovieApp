import Combine

protocol MovieClientProtocol {

    var popularMovies: AnyPublisher<MovieListClientModel, Error> { get }

    func fetchTopRatedMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchTrendingMovies(
        for timeWindow: TimeWindowClientModel,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

    func fetchMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieClientModel, RequestError>) -> Void
    )

    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<DetailedMovieClientModel, Error>

    func fetchMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsClientModel, RequestError>) -> Void
    )

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
