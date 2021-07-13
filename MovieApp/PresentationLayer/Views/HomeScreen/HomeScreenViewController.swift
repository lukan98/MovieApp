import UIKit

class HomeScreenViewController: UIViewController {

    private var homeScreenPresenter: HomeScreenPresenterProtocol!
    var navigationView: NavBarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

}
