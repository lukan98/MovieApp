import UIKit

class MainRouter: RouterProtocol {

    private let appDependencies = AppDependencies()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(in window: UIWindow) {
        navigationController.navigationBar.isHidden = true

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let tabBarController = makeUITabBarController()

        navigationController.pushViewController(tabBarController, animated: false)
    }

    private func makeUITabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(named: "DarkBlue")
        tabBarController.tabBar.isTranslucent = false

        let styledFont = UIFont(name: "ProximaNova-Medium", size: 10)

        let homeScreen = HomeScreenViewController(
            presenter: HomeScreenPresenter(
                movieUseCase: appDependencies.movieUseCase,
                genreUseCase: appDependencies.genreUseCase))
        homeScreen.styleForTabBar(
            title: "Home",
            image: UIImage(named: "Home-outline"),
            selectedImage: UIImage(named: "Home-fill"),
            font: styledFont)

        let favorites = FavoritesViewController(presenter: FavoritesPresenter(useCase: appDependencies.movieUseCase))
        favorites.styleForTabBar(
            title: "Favorites",
            image: UIImage(named: "Favorites-outline"),
            selectedImage: UIImage(named: "Favorites-fill"),
            font: styledFont)

        tabBarController.viewControllers = [homeScreen, favorites]

        return tabBarController
    }
    
}
