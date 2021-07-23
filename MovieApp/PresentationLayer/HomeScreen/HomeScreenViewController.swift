import UIKit

class HomeScreenViewController: UIViewController {

    let movies = MockHomeScreenData.data

    var navigationView: NavBarView!
    var searchBar: SearchBar!
    var categoryCollection: CategoryCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        categoryCollection.setData(movies: movies)
    }

}
