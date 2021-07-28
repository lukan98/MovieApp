class GenreClient: GenreClientProtocol {

    private let baseApiClient: BaseApiClient

    init(baseApiClient: BaseApiClient) {
        self.baseApiClient = baseApiClient
    }

    func fetchGenres(_ completionHandler: @escaping (Result<GenreListClientModel, RequestError>) -> Void) {
        baseApiClient
            .get(
                path: "/genre/movie/list",
                completionHandler: completionHandler
            )
    }

}
