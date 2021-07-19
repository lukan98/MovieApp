class AppDependencies {

    lazy var baseApiClient = BaseApiClient(baseUrl: "https://api.themoviedb.org/3")
    lazy var movieClient: MovieClientProtocol = {
        MovieClient(baseApiClient: baseApiClient)
    }()
    lazy var networkDataSource: NetworkDataSourceProtocol = {
        NetworkDataSource(movieClient: movieClient)
    }()
    lazy var movieRepository: MovieRepositoryProtocol = {
        MovieRepository(networkDataSource: networkDataSource)
    }()
    lazy var movieUseCase: MovieUseCaseProtocol = {
        MovieUseCase(movieRepository: movieRepository)
    }()

}
