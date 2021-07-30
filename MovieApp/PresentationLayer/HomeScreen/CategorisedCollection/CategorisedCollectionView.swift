import UIKit

class CategorisedCollectionView: UIView {

    let defaultInset: CGFloat = 20
    let defaultSpacing: CGFloat = 10

    var onCategoryChanged: (Int) -> Void = { _ in }
    var onMovieFavorited: (Int) -> Void = { _ in }

    var titleLabel: UILabel!
    var categoriesView: ButtonBarView!
    var movieCollectionView: UICollectionView!
    var currentlySelectedCategory: OptionViewModel {
        let index = categoriesView.selectedButtonIndex
        guard
            index >= 0,
            index < self.categories.count
        else {
            return categories[0]
        }

        return categories[index]
    }

    private var categories: [OptionViewModel] = []
    private var movies: [MovieViewModel] = []

    init() {
        super.init(frame: .zero)

        buildViews()
        bindViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

    func setInitialData(title: String, options: [OptionViewModel]) {
        self.titleLabel.text = title
        self.categories = options
        categoriesView.setData(optionTitles: options.map { $0.name })
    }

    func setData(_ data: [MovieViewModel], _ animated: Bool) {
        self.movies = data
        if animated {
            animatedDataReload()
        } else {
            movieCollectionView.reloadData()
        }
    }

    private func bindViews() {
        categoriesView.onButtonSelected = { [weak self] index in
            guard
                let self = self,
                index >= 0,
                index < self.categories.count
            else {
                return
            }

            let optionId = self.categories[index].id
            self.onCategoryChanged(optionId)
        }
    }

    
}

// MARK: UICollectionViewDataSource
extension CategorisedCollectionView: UICollectionViewDataSource {

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

        let movie = movies[indexPath.row]
        cell.setData(for: movie)
        cell.moviePoster.onFavoriteToggle = onMovieFavorited
        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension CategorisedCollectionView: UICollectionViewDelegateFlowLayout {

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
