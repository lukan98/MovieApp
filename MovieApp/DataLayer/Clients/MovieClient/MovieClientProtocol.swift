protocol MovieClientProtocol {

    func fetchPopularMovies(completionHandler: @escaping (Result<PopularMoviesModel, RequestError>) -> Void)

}
