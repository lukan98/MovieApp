protocol GenreNetworkDataSourceProtocol {

    func fetchGenres(
        _ completionHandler: @escaping (Result<[GenreDataSourceModel], RequestError>) -> Void
    )

}
