import UIKit

class MainRouter: RouterProtocol {

    private let appDependencies = AppDependencies()

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showMainAppScreen()
    }

    private func showMainAppScreen() {
        navigationController.navigationBar.isHidden = true
        let tabBarController = makeUITabBarController()
        navigationController.setViewControllers([tabBarController], animated: false)
    }

    private func makeUITabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .darkBlue
        tabBarController.tabBar.isTranslucent = false

        let styledFont = ProximaNova.medium.of(size: 10)

        let homeScreen = HomeScreenViewController(
            presenter: HomeScreenPresenter(
                movieUseCase: appDependencies.movieUseCase,
                genreUseCase: appDependencies.genreUseCase),
            router: self)
        homeScreen.styleForTabBar(
            title: "Home",
            image: .homeOutlined,
            selectedImage: .homeFilled,
            font: styledFont)

        let favorites = FavoritesViewController(
            presenter: FavoritesPresenter(useCase: appDependencies.movieUseCase),
            router: self)
        favorites.styleForTabBar(
            title: "Favorites",
            image: .favoritesOutlined,
            selectedImage: .favoritesFilled,
            font: styledFont)

        tabBarController.viewControllers = [homeScreen, favorites]

        return tabBarController
    }

}

// MARK: MovieDetailsRoute
extension MainRouter: MovieDetailsRouterProtocol {

    func showMovieDetails(for movieId: Int) {
        let movieDetailsPresenter = MovieDetailsPresenter(useCase: appDependencies.movieUseCase)
        let movieDetailsViewController = MovieDetailsViewController(
            presenter: movieDetailsPresenter,
            router: self,
            for: movieId)

        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
