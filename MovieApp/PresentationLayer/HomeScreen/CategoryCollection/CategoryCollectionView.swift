import UIKit

class CategoryCollectionView: UIView {

    let defaultInset: CGFloat = 20
    let defaultSpacing: CGFloat = 10

    var title: UILabel!
    var options: OptionBar!
    var filmCollection: UICollectionView!

    private var movies: [MovieViewModel] = [] {
        didSet {
            filmCollection.reloadData()
        }
    }

    init() {
        super.init(frame: .zero)

        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        defineLayoutForViews()
    }

    func setData(movies: [MovieViewModel]) {
        self.movies = movies
    }
    
    func setDelegate(_ collectionViewFlowDelegateFlowLayout: UICollectionViewDelegateFlowLayout) {
        filmCollection.delegate = collectionViewFlowDelegateFlowLayout
    }
    
}

// MARK: UICollectionViewDataSource

extension CategoryCollectionView: UICollectionViewDataSource {

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
            let cell = filmCollection.dequeueReusableCell(
                withReuseIdentifier: MoviePosterCell.cellIdentifier,
                for: indexPath) as? MoviePosterCell
        else {
            return MoviePosterCell()
        }

        cell.setData(for: movies[indexPath.row])
        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout

extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {

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
        UIEdgeInsets(top: 0, left: defaultInset, bottom: 0, right: defaultInset)
    }

}
