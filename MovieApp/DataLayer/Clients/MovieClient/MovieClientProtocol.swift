import Combine

protocol MovieClientProtocol {

    var popularMovies: AnyPublisher<MovieListClientModel, Error> { get }
    var topRatedMovies: AnyPublisher<MovieListClientModel, Error> { get }

    func trendingMovies(for timeWindow: TimeWindowClientModel) -> AnyPublisher<MovieListClientModel, Error>

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieClientModel, Error>

    func credits(for movieId: Int) -> AnyPublisher<CreditsClientModel, Error>

    func reviews(for movieId: Int) -> AnyPublisher<ReviewListClientModel, Error>

    func recommendations(basedOn movieId: Int) -> AnyPublisher<MovieRecommendationListClientModel, Error>

    func searchResults(for query: String) -> AnyPublisher<MovieListClientModel, Error>

    func fetchMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )
}
