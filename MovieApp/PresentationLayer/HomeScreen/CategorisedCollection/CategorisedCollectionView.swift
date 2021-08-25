import UIKit
import Combine

class CategorisedCollectionView: UIView {

    let defaultInset: CGFloat = 20
    let defaultSpacing: CGFloat = 10
    
    var titleLabel: UILabel!
    var categoriesView: ButtonBarView!
    var movieCollectionView: UICollectionView!
    var currentlySelectedCategory: AnyPublisher<OptionViewModel, Never> {
        categoriesView
            .selectedButtonIndex
            .compactMap { [weak self] index -> OptionViewModel? in
                guard let category = self?.categories.at(index) else { return nil }

                return category
            }
            .eraseToAnyPublisher()
    }
    var movieSelected: AnyPublisher<Int, Error> {
        movieSelectedSubject
            .eraseToAnyPublisher()
    }

    private let movieSelectedSubject = PassthroughSubject<Int, Error>()

    private var categories: [OptionViewModel] = []
    private var movies: [MovieViewModel] = []
    private var disposables = Set<AnyCancellable>()

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

    func setInitialData(title: String, options: [OptionViewModel]) {
        self.titleLabel.text = title
        self.categories = options
        categoriesView.setData(optionTitles: options.map { $0.name })
    }

    func setData(_ data: [MovieViewModel], animated: Bool) {
        self.movies = data
        if animated {
            animatedDataReload()
        } else {
            movieCollectionView.reloadData()
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
        cell.setData(id: movie.id, isFavorited: movie.isFavorited, posterSource: movie.posterSource)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let movie = movies.at(indexPath.row) else { return }

        movieSelectedSubject.send(movie.id)
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
