import UIKit

class FavoritesViewController: UIViewController {

    var onMovieFavorited: (Int) -> Void = { _ in }
    var navigationView: NavBarView!
    var favoritesLabel: UILabel!
    var movieCollectionView: UICollectionView!

    private let inset: CGFloat = 20
    private let verticalSpacing: CGFloat = 35
    private let presenter: FavoritesPresenter

    private var movies: [MovieViewModel] = []

    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        loadData()
    }

    private func loadData() {
        presenter.getFavoriteMovies { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movieViewModels):
                self.movies = movieViewModels
                self.movieCollectionView.reloadData()
            case .failure:
                print("Failed to get favorite movies!")
            }
        }
    }

}

extension FavoritesViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        movies.count
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

        cell.setData(for: movies[indexPath.row])
        cell.moviePoster.onFavoriteToggle = onMovieFavorited
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
