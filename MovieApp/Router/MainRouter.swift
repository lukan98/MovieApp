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
        let homeScreenViewController = HomeScreenViewController(
            presenter: homeScreenPresenter,
            router: self)

        navigationController.pushViewController(homeScreenViewController, animated: false)
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
