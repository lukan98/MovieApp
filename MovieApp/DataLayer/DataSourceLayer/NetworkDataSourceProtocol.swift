protocol NetworkDataSourceProtocol{

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    )

}
