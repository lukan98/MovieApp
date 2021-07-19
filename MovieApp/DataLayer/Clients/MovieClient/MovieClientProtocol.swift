protocol MovieClientProtocol {

    func fetchPopularMovies(_ completionHandler: @escaping (Result<PopularMoviesModel, RequestError>) -> Void)

}
