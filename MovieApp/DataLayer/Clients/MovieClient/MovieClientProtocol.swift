protocol MovieClientProtocol {

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<MovieListClientModel, RequestError>) -> Void
    )

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

    func fetchMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsClientModel, RequestError>) -> Void
    )

    func fetchMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<ReviewListClientModel, RequestError>) -> Void
    )
    
}
