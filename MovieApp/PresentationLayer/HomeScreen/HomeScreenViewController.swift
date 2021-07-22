import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var searchBar: SearchBar!
    var categoryCollection: CategoryCollection!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
    }

}
