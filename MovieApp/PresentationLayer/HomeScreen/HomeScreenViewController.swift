import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var searchBar: SearchBar!
    var optionView: OptionBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
    }

}
