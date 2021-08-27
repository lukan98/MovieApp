import Combine

protocol MovieUseCaseProtocol {

    var favoriteMovies: AnyPublisher<[DetailedMovieModel], Error> { get }

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error>

    func topRatedMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error>

    func trendingMovies(for timeWindow: TimeWindowModel) -> AnyPublisher<[MovieModel], Error>

    func toggleFavorited(for movieId: Int)

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieModel, RequestError>) -> Void
    )

    func getMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsModel, RequestError>) -> Void
    )

    func getMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewModel], RequestError>) -> Void
    )

    func getMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationModel], RequestError>) -> Void
    )

    func getMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

}
