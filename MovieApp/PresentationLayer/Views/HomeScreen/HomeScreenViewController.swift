import UIKit

class HomeScreenViewController: UIViewController {

    var navigationView: NavBarView!
    var movieCollection: UICollectionView!

    private let widthInset: CGFloat = 36
    private let cellHeight: CGFloat = 140

    private var presenter: HomeScreenPresenter!

    init(presenter: HomeScreenPresenter) {
        super .init(nibName: nil, bundle: nil)

        self.presenter = presenter
        presenter.fetchMovies()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.numberOfMovies
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = movieCollection.dequeueReusableCell(
                withReuseIdentifier: MovieInfoCell.cellIdentifier,
                for: indexPath) as? MovieInfoCell,
            let movie = presenter.getMovie(at: indexPath.row)
        else {
            return MovieInfoCell()
        }
        
        cell.setData(for: movie)
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
        UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
    }

}
