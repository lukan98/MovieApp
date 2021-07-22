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

// MARK: UICollectionViewDelegateFlowLayout

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 122, height: 180)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: categoryCollection.defaultInset, bottom: 0, right: categoryCollection.defaultInset)
    }

}
