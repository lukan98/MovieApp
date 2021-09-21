import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerClients()
        registerDataSources()
        registerRepositories()
    }

}

class AppDependencies {

    lazy var baseApiClient = BaseApiClient(baseUrl: "https://api.themoviedb.org/3")
    lazy var movieClient: MovieClientProtocol = {
        MovieClient(baseApiClient: baseApiClient)
    }()
    lazy var genreClient: GenreClientProtocol = {
        GenreClient(baseApiClient: baseApiClient)
    }()
    lazy var genreNetworkDataSource: GenreNetworkDataSourceProtocol = {
        GenreNetworkDataSource(genreClient: genreClient)
    }()
    lazy var movieNetworkDataSource: MovieNetworkDataSourceProtocol = {
        MovieNetworkDataSource(movieClient: movieClient)
    }()
    lazy var movieLocalDataSource: MovieLocalDataSourceProtocol = {
        MovieLocalDataSource()
    }()
    lazy var movieUserDefaultsDataSource: MovieLocalMetadataSourceProtocol = {
        MovieUserDefaultsDataSource()
    }()
    lazy var movieRepository: MovieRepositoryProtocol = {
        MovieRepository(
            networkDataSource: movieNetworkDataSource,
            localDataSource: movieLocalDataSource,
            localMetadataSource: movieUserDefaultsDataSource)
    }()
    lazy var genreRepository: GenreRepositoryProtocol = {
        GenreRepository(networkDataSource: genreNetworkDataSource)
    }()
    lazy var movieUseCase: MovieUseCaseProtocol = {
        MovieUseCase(movieRepository: movieRepository)
    }()
    lazy var genreUseCase: GenreUseCaseProtocol = {
        GenreUseCase(genreRepository: genreRepository)
    }()

}
