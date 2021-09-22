import UIKit
import Resolver

class MainRouter: RouterProtocol, Resolving {

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
        styleNavigationController(navigationController)

        let tabBarController = makeUITabBarController()
        navigationController.setViewControllers([tabBarController], animated: false)
    }

    private func styleNavigationController(_ navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = .darkBlue
    }

    private func makeUITabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .darkBlue
        tabBarController.tabBar.isTranslucent = false

        let styledFont = ProximaNova.medium.of(size: 10)

        let homeScreen = HomeScreenViewController(
            presenter: resolver.resolve(),
            router: self)
        homeScreen.styleForTabBar(
            title: "Home",
            image: .homeOutlined,
            selectedImage: .homeFilled,
            font: styledFont)

        let favorites = FavoritesViewController(
            presenter: resolver.resolve(),
            router: self)
        favorites.styleForTabBar(
            title: "Favorites",
            image: .favoritesOutlined,
            selectedImage: .favoritesFilled,
            font: styledFont)

        tabBarController.viewControllers = [homeScreen, favorites]

        tabBarController.navigationItem.titleView = UIImageView(image: .logo)

        return tabBarController
    }

}

// MARK: MovieDetailsRoute
extension MainRouter: MovieDetailsRouterProtocol {

    func showMovieDetails(for movieId: Int) {
        let movieDetailsViewController = MovieDetailsViewController(
            presenter: resolver.resolve(),
            router: self,
            for: movieId)

        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
