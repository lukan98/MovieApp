import UIKit

class HomeScreenViewController: UIViewController {

    let movies = MockHomeScreenData.data

    var navigationView: NavBarView!
    var searchBar: SearchBarView!
    var categoryCollection: CategoryCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        categoryCollection.setData(movies: movies)
    }

}
