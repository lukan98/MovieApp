import Combine

protocol MovieUseCaseProtocol {

    var favoriteMovies: AnyPublisher<[DetailedMovieModel], Error> { get }

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void)

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error>

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

    func getTrendingMovies(
        for timeWindow: TimeWindowModel,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

    func toggleFavorited(for movieId: Int)

    func getFavoriteMovies(
        _ completionHandler: @escaping (Result<[DetailedMovieModel], RequestError>) -> Void
    )

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
