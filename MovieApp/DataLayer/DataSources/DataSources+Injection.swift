import Resolver

extension Resolver {

    public static func registerDataSources() {
        register(GenreNetworkDataSourceProtocol.self) {
            GenreNetworkDataSource(genreClient: resolve())
        }
        .scope(.application)

        register(MovieLocalDataSourceProtocol.self) {
            MovieLocalDataSource()
        }
        .scope(.application)

        register(MovieLocalMetadataSourceProtocol.self) {
            MovieUserDefaultsDataSource()
        }
        .scope(.application)

        register(MovieNetworkDataSourceProtocol.self) {
            MovieNetworkDataSource(movieClient: resolve())
        }
        .scope(.application)
    }

}
