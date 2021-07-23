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
        setData()
    }

    private func setData() {
        for subview in stackView.subviews {
            guard let categoryCollection = subview as? CategoryCollectionView
            else {
                return
            }

            categoryCollection.setData(movies: movies)
        }
    }

}
