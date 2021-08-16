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

        let homeScreenPresenter = HomeScreenPresenter(
            movieUseCase: appDependencies.movieUseCase,
            genreUseCase: appDependencies.genreUseCase)
        let homeScreenViewController = HomeScreenViewController(presenter: homeScreenPresenter)

        navigationController.pushViewController(homeScreenViewController, animated: false)
    }
    
}
