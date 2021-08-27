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
    var movieFavorited: AnyPublisher<Int, Error> {
        movieFavoritedSubject
            .eraseToAnyPublisher()
    }

    private let movieSelectedSubject = PassthroughSubject<Int, Error>()
    private let movieFavoritedSubject = PassthroughSubject<Int, Error>()

    private var categories: [OptionViewModel] = []
    private var movies: [MovieViewModel] = []
    private var disposables = Set<AnyCancellable>()
    private var currentlySelectedCategorySubject = CurrentValueSubject<OptionViewModel?, Never>(nil)

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

    func setData(_ data: [MovieViewModel], animated: Bool) {
        self.movies = data
        if animated {
            animatedDataReload()
        } else {
            movieCollectionView.reloadData()
        }
    }

    private func bindViews() {
        categoriesView
            .selectedButtonIndex
            .compactMap { [weak self] index -> OptionViewModel? in
                guard let category = self?.categories.at(index) else { return nil }

                return category
            }
            .sink { [weak self] viewModel in
                self?.currentlySelectedCategorySubject.send(viewModel)
            }
            .store(in: &disposables)
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
                for: indexPath) as? MoviePosterCell,
            let movie = movies.at(indexPath.row)
        else {
            return UICollectionViewCell()
        }

        cell.setData(id: movie.id, isFavorited: movie.isFavorited, posterSource: movie.posterSource)
        cell.favoritedToggle
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieId in
                    self?.movieFavoritedSubject.send(movieId)
                })
            .store(in: &cell.disposables)
        
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
