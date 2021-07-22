import UIKit

class CategoryCollectionView: UIView {

    private var movies: [MovieViewModel] = [] {
        didSet {
            filmCollection.reloadData()
        }
    }

    let defaultInset: CGFloat = 20
    let defaultSpacing: CGFloat = 10

    var title: UILabel!
    var options: OptionBar!
    var filmCollection: UICollectionView!

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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
