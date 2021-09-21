import Resolver

extension Resolver {

    public static func registerUseCases() {
        register(GenreUseCaseProtocol.self) {
            GenreUseCase(genreRepository: resolve())
        }
        .scope(.application)

        register(MovieUseCaseProtocol.self) {
            MovieUseCase(movieRepository: resolve())
        }
        .scope(.application)
    }

}
