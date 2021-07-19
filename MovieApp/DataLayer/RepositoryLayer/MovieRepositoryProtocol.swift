protocol MovieRepositoryProtocol {

    func getPopularMovies(
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

//    func getPopularMoviesFromNetwork(
//        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
//    )
//
//    func getPopularMoviesFromLocal() -> [Movie]

}
