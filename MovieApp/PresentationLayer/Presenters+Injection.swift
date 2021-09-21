import Resolver

extension Resolver {

    public static func registerPresenters() {
        register { FavoritesPresenter(useCase: resolve()) }
            .scope(.unique)

        register {
            HomeScreenPresenter(
                movieUseCase: resolve(),
                genreUseCase: resolve())
        }
        .scope(.unique)

        register { MovieDetailsPresenter(useCase: resolve()) }
            .scope(.unique)
    }

}
