import UIKit

class FavoritesViewController: UIViewController {

    var navigationView: NavBarView!
    var favoritesLabel: UILabel!
    var movieCollectionView: UICollectionView!

    private let inset: CGFloat = 20
    private let verticalSpacing: CGFloat = 35

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
    }

}

extension FavoritesViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        100
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = movieCollectionView.dequeueReusableCell(
                withReuseIdentifier: MoviePosterCell.cellIdentifier,
                for: indexPath) as? MoviePosterCell
        else {
            let cell = MoviePosterCell()
            return cell
        }

        let movie = MovieViewModel(
            id: 1,
            about: "",
            name: "",
            posterSource: "https://image.tmdb.org/t/p/w185/rYFAvSPlQUCebayLcxyK79yvtvV.jpg",
            genres: [],
            isFavorited: true)
        
        cell.setData(for: movie)
        cell.moviePoster.onFavoriteToggle = { _ in }
        return cell
    }

}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 105, height: 155)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        verticalSpacing
    }

}
