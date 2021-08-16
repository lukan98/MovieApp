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

        let styledFont = ProximaNova.medium.of(size: 10)

        let homeScreen = HomeScreenViewController(
            presenter: HomeScreenPresenter(
                movieUseCase: appDependencies.movieUseCase,
                genreUseCase: appDependencies.genreUseCase),
            router: self)
        homeScreen.styleForTabBar(
            title: "Home",
            image: UIImage(named: "Home-outline"),
            selectedImage: UIImage(named: "Home-fill"),
            font: styledFont)

        let favorites = FavoritesViewController(
            presenter: FavoritesPresenter(useCase: appDependencies.movieUseCase),
            router: self)
        favorites.styleForTabBar(
            title: "Favorites",
            image: UIImage(named: "Favorites-outline"),
            selectedImage: UIImage(named: "Favorites-fill"),
            font: styledFont)

        tabBarController.viewControllers = [homeScreen, favorites]

        return tabBarController
    }

}

// MARK: MovieDetailsRoute
extension MainRouter: MovieDetailsRouterProtocol {

    func routeToDetails(for movieId: Int) {
        let movieDetailsPresenter = MovieDetailsPresenter(useCase: appDependencies.movieUseCase)
        let movieDetailsViewController = MovieDetailsViewController(
            presenter: movieDetailsPresenter,
            router: self,
            for: movieId)

        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }

    func routeBack() {
        navigationController.popViewController(animated: true)
    }

}
