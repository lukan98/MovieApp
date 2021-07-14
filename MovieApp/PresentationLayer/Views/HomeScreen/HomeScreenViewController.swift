import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var movieCollection: UICollectionView!

    private let widthInset: CGFloat = 36
    private let cellHeight: CGFloat = 152
    private var homeScreenPresenter: HomeScreenPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        movieCollection.collectionViewLayout.invalidateLayout()
    }

}

// MARK: CollectionView Data Source

extension HomeScreenViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView
        , numberOfItemsInSection section: Int
    ) -> Int {
        20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = movieCollection.dequeueReusableCell(
            withReuseIdentifier: MovieInfoCell.cellIdentifier,
            for: indexPath
        )
        return cell
    }

}

// MARK: CollectionViewDelegate Flow Layout

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - widthInset, height: cellHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 22, left: 0, bottom: 6, right: 0)
    }

}
