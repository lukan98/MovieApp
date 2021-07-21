import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var searchBar: SearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
    }

}
