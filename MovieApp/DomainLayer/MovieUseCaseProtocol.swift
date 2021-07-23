protocol MovieUseCaseProtocol {

    func getPopularMovies(_ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void)

    func getPopularMoviesCategorised() -> [String: [MovieModel]]

    func getFreeToWatchMoviesCategorised() -> [String: [MovieModel]]

    func getTrendingMoviesCategorised() -> [String: [MovieModel]]

}
