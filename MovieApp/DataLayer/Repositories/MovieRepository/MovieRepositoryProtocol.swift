protocol MovieRepositoryProtocol {

    var favoriteMovies: [Int] { get }

    func getPopularMovies(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func getTrendingMovies(
        for timeWindow: TimeWindowRepositoryModel,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

    func toggleFavorited(for movieId: Int)

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieRepositoryModel, RequestError>) -> Void
    )

    func getMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsRepositoryModel, RequestError>) -> Void
    )

    func getMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewRepositoryModel], RequestError>) -> Void
    )

}
