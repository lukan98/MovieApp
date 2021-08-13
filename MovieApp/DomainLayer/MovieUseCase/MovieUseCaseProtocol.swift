protocol MovieUseCaseProtocol {

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void)

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

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

}
