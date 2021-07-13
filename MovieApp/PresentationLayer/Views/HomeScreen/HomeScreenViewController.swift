import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!

    private var homeScreenPresenter: HomeScreenPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

}
