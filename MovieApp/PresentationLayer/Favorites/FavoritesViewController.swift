import UIKit
import Combine

class FavoritesViewController: UIViewController {

    private enum Section {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DetailedMovieViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DetailedMovieViewModel>

    let spacing: CGFloat = 20

    var favoritesLabel: UILabel!
    var movieCollectionView: UICollectionView!

    private let verticalSpacing: CGFloat = 35

    private let presenter: FavoritesPresenter
    private let router: MovieDetailsRouterProtocol

    private var disposables = Set<AnyCancellable>()

    private lazy var dataSource = makeDataSource()

    init(presenter: FavoritesPresenter, router: MovieDetailsRouterProtocol) {
        self.presenter = presenter
        self.router = router

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barStyle = .black
    }

    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.cellIdentifier)
        collectionView.delegate = self

        return collectionView
    }

    private func bindViews() {
        presenter.favoriteMovies
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieViewModels in
                    guard let self = self else { return }

                    var snapshot = Snapshot()
                    snapshot.appendSections([.main])
                    snapshot.appendItems(movieViewModels)
                    self.dataSource.apply(snapshot, animatingDifferences: true)
                })
            .store(in: &disposables)
    }

    private func makeDataSource() -> DataSource {
        DataSource(collectionView: movieCollectionView) { (collection, indexPath, movie)
            -> UICollectionViewCell? in
            guard
                let cell = collection.dequeueReusableCell(
                    withReuseIdentifier: MoviePosterCell.cellIdentifier,
                    for: indexPath) as? MoviePosterCell
            else {
                return UICollectionViewCell()
            }

            cell.setData(id: movie.id, isFavorited: movie.isFavorited, posterSource: movie.posterSource)

            cell.favoritedToggle
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] movieId in
                        self?.presenter.toggleFavorited(for: movieId)
                    })
                .store(in: &cell.disposables)

            cell
                .throttledTapGesture()
                .sink { [weak self] _ in
                    self?.router.showMovieDetails(for: movie.id)
                }
                .store(in: &cell.disposables)

            return cell
        }
    }

}

// MARK: UICollectionViewDelegateFlowLayout
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
        UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        verticalSpacing
    }

}
