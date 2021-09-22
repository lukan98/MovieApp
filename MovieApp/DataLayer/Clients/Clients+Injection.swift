import Resolver

extension Resolver {

    public static func registerClients() {
        let baseUrl = "https://api.themoviedb.org/3"

        register { BaseApiClient(baseUrl: baseUrl) }
            .scope(.application)

        register(GenreClientProtocol.self) { GenreClient(baseApiClient: resolve()) }
            .scope(.application)

        register(MovieClientProtocol.self) { MovieClient(baseApiClient: resolve()) }
            .scope(.application)
    }

}
