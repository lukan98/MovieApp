import UIKit
import Combine

class CategorisedCollectionView: UIView {

    private enum Section {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewModel>

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
            .receiveOnBackground()
    }

    private let movieSelectedSubject = PassthroughSubject<Int, Error>()
    private let movieFavoritedSubject = PassthroughSubject<Int, Error>()
    private let currentlySelectedCategorySubject = CurrentValueSubject<OptionViewModel?, Never>(nil)

    private var categories: [OptionViewModel] = []
    private var disposables = Set<AnyCancellable>()

    private lazy var dataSource = makeDataSource()

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

    func setData(_ data: [MovieViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func bindViews() {
        categoriesView
            .selectedButtonIndex
            .compactMap { [weak self] index in
                self?.categories.at(index)
            }
            .sink { [weak self] viewModel in
                self?.currentlySelectedCategorySubject.send(viewModel)
            }
            .store(in: &disposables)
    }

    private func makeDataSource() -> DataSource {
        DataSource(collectionView: movieCollectionView) { (collectionView, indexPath, movieViewModel)
            -> UICollectionViewCell? in
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MoviePosterCell.cellIdentifier,
                    for: indexPath) as? MoviePosterCell
            else {
                return UICollectionViewCell()
            }

            cell.setData(
                id: movieViewModel.id,
                isFavorited: movieViewModel.isFavorited,
                posterSource: movieViewModel.posterSource)

            cell.favoritedToggle
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] movieId in
                        self?.movieFavoritedSubject.send(movieId)
                    })
                .store(in: &cell.disposables)

            cell.tapGesture()
                .sink { [weak self] _ in
                    self?.movieSelectedSubject.send(movieViewModel.id)
                }
                .store(in: &cell.disposables)

            return cell
        }
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
