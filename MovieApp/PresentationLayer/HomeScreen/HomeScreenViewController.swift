import UIKit

class HomeScreenViewController: UIViewController {

    let movies = MockHomeScreenData.data

    var navigationView: NavBarView!
    var searchBar: SearchBarView!
    var scrollView: UIScrollView!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        stackView.subviews
            .compactMap { $0 as? CategoryCollectionView }
            .forEach { $0.setData(movies: movies) }
    }

}
