import UIKit

class CategorisedCollectionView: UIView {

    let defaultInset: CGFloat = 20
    let defaultSpacing: CGFloat = 10

    var onCategoryChanged: (Int) -> Void = { _ in }

    var titleLabel: UILabel!
    var optionsView: ButtonBarView!
    var movieCollectionView: UICollectionView!

    private var options: [OptionViewModel] = []
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
        DispatchQueue.main.async { self.titleLabel.text = title }
        self.options = options
        optionsView.setData(optionTitles: options.map { $0.name })
    }

    func setData(_ data: [MovieViewModel]) {
        self.movies = data
        animatedDataReload()
    }

    private func bindViews() {
        optionsView.onButtonSelected = { [weak self] index in
            guard
                let self = self,
                index >= 0,
                index < self.options.count
            else {
                return
            }

            let optionId = self.options[index].id
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
            return MoviePosterCell()
        }

        let movie = movies[indexPath.row]
        cell.setData(for: movie)
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
