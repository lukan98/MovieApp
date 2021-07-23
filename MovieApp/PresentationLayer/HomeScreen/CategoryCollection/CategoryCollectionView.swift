import UIKit

class CategoryCollectionView: UIView {

    let defaultInset: CGFloat = 20
    let defaultSpacing: CGFloat = 10

    var title: UILabel!
    var options: OptionBarView!
    var movieCollection: UICollectionView!

    private var movies: [[MovieViewModel]] = []
    var currentlySelectedIndex = 0 {
        didSet {
            reloadData()
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
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

    func setData(title: String, options: [String], movies: [[MovieViewModel]]) {
        self.title.text = title

        self.options.setData(optionTitles: options)

        self.movies = movies
    }
    
}

// MARK: UICollectionViewDataSource

extension CategoryCollectionView: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        movies[currentlySelectedIndex].count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = movieCollection.dequeueReusableCell(
                withReuseIdentifier: MoviePosterCell.cellIdentifier,
                for: indexPath) as? MoviePosterCell
        else {
            return MoviePosterCell()
        }

        cell.setData(for: movies[currentlySelectedIndex][indexPath.row])
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
        UIEdgeInsets(top: 0, left: defaultInset, bottom: defaultInset, right: defaultInset)
    }

}
