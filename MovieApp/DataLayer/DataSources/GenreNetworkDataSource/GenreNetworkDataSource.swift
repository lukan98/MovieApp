class GenreNetworkDataSource: GenreNetworkDataSourceProtocol {

    private let genreClient: GenreClientProtocol

    init(genreClient: GenreClientProtocol) {
        self.genreClient = genreClient
    }

    func fetchGenres(_ completionHandler: @escaping (Result<[GenreDataSourceModel], RequestError>) -> Void) {
        genreClient.fetchGenres { result in
            completionHandler(result.map { $0.genres.map { GenreDataSourceModel(from: $0) } })
        }
    }

}
