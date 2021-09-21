import Resolver

extension Resolver {

    public static func registerRepositories() {

        register(GenreRepositoryProtocol.self) {
            GenreRepository(networkDataSource: resolve())
        }.scope(.application)

        register(MovieRepositoryProtocol.self) {
            MovieRepository(
                networkDataSource: resolve(),
                localDataSource: resolve(),
                localMetadataSource: resolve())
        }.scope(.application)

    }

}
