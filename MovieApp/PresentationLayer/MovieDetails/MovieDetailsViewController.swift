import UIKit
import Combine

class MovieDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    private enum Section {
        case main
    }

    private typealias CastMemberDataSource = UICollectionViewDiffableDataSource<Section, CastMemberViewModel>
    private typealias RecommendationDataSource = UICollectionViewDiffableDataSource<Section,
                                                                                    MovieRecommendationViewModel>
    private typealias CastMemberSnapshot = NSDiffableDataSourceSnapshot<Section, CastMemberViewModel>
    private typealias RecommendationSnapshot = NSDiffableDataSourceSnapshot<Section, MovieRecommendationViewModel>

    let spacing: CGFloat = 5
    let noOfCrewRows = 3
    let noOfCrewColumns = 3

    var scrollView: UIScrollView!
    var contentView: UIView!
    var headerView: MovieHeaderView!
    var crewGridView: UIStackView!
    var crewGridRows: [UIStackView]!
    var crewMemberLabels: [CrewMemberLabelsView]!
    var overviewTitleLabel: UILabel!
    var overviewLabel: UILabel!
    var topBilledCastLabel: UILabel!
    var topBilledCastCollection: UICollectionView!
    var socialLabel: UILabel!
    var noReviewsLabel: UILabel!
    var reviewsContainerView: UIView!
    var reviewsViewController: ReviewsViewController!
    var recommendationLabel: UILabel!
    var recommendationCollection: UICollectionView!
    var noRecommendationsLabel: UILabel!

    private let movieId: Int
    private let presenter: MovieDetailsPresenter

    private var disposables = Set<AnyCancellable>()

    private weak var router: MovieDetailsRouterProtocol?

    private lazy var castMemberDataSource = makeCastMemberDataSource()
    private lazy var recommendationDataSource = makeRecommendationDataSource()

    init(presenter: MovieDetailsPresenter, router: MovieDetailsRouterProtocol, for movieId: Int) {
        self.presenter = presenter
        self.router = router
        self.movieId = movieId

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        styleNavigationBar()
        buildViews()
        bindViews()
        setInitialData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barStyle = .black
    }

    func makeCastCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(CastMemberCell.self, forCellWithReuseIdentifier: CastMemberCell.cellIdentifier)

        return collectionView
    }

    func makeRecommendationCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(MovieBackdropCell.self, forCellWithReuseIdentifier: MovieBackdropCell.cellIdentifier)

        return collectionView
    }

    private func bindViews() {
        headerView
            .favoritedToggle
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieId in
                    self?.presenter.toggleFavorited(for: movieId)
                })
            .store(in: &disposables)

        presenter
            .details(for: movieId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] detailedMovieViewModel in
                    self?.setMovieDetailsData(for: detailedMovieViewModel)
                })
            .store(in: &disposables)

        presenter
            .credits(for: movieId, maxCrewMembers: noOfCrewRows * noOfCrewColumns)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] creditsViewModel in
                    self?.setCreditsData(for: creditsViewModel)
                })
            .store(in: &disposables)

        presenter
            .reviews(for: movieId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] reviewViewModels in
                    self?.setReviewData(for: reviewViewModels)
                })
            .store(in: &disposables)

        presenter
            .recommendations(basedOn: movieId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] recommendationViewModels in
                    self?.setRecommendationData(for: recommendationViewModels)
                })
            .store(in: &disposables)
    }

    private func setMovieDetailsData(for movie: DetailedMovieViewModel) {
        headerView.setData(for: movie)
        overviewLabel.text = movie.about
    }

    private func setCreditsData(for credits: CreditsViewModel) {
        setCrewGridData(for: credits.crew)
        hideEmptyCrewLabels()

        var snapshot = CastMemberSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(credits.cast)
        castMemberDataSource.apply(snapshot)
    }

    private func setCrewGridData(for crew: [CrewMemberViewModel]) {
        for (index, crewMember) in crew.enumerated() {
            guard let crewMemberLabel = crewMemberLabels.at(index)
            else {
                return
            }

            crewMemberLabel.setData(name: crewMember.name, job: crewMember.job)
        }
    }

    private func hideEmptyCrewLabels() {
        crewGridView.subviews
            .filter { stackView in
                return stackView.subviews.allSatisfy { subview in
                    guard
                        let crewMemberLabelView = subview as? CrewMemberLabelsView
                    else {
                        return false
                    }

                    return crewMemberLabelView.nameLabel.text == nil && crewMemberLabelView.jobLabel.text == nil
                }
            }
            .forEach { $0.isHidden = true }
    }

    private func setReviewData(for reviews: [ReviewViewModel]) {
        if reviews.count == 0 {
            showReviewsError(message: "No reviews available for this title.")
        } else {
            reviewsViewController.setData(for: reviews)
        }
    }

    private func showReviewsError(message: String) {
        reviewsViewController.view.isHidden = true
        noReviewsLabel.text = message
        noReviewsLabel.isHidden = false

        reviewsContainerView.snp.remakeConstraints {
            $0.top.equalTo(socialLabel.snp.bottom).offset(3 * spacing)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setRecommendationData(for recommendations: [MovieRecommendationViewModel]) {
        if recommendations.count == 0 {
            showRecommendationsError(message: "No recommendations available based on this title")
        } else {
            var snapshot = RecommendationSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(recommendations)
            recommendationDataSource.apply(snapshot)
        }
    }

    private func showRecommendationsError(message: String) {
        recommendationCollection.isHidden = true
        noRecommendationsLabel.text = message
        noRecommendationsLabel.isHidden = false
    }

    private func setInitialData() {
        overviewTitleLabel.text = "Overview"

        topBilledCastLabel.text = "Top Billed Cast"

        socialLabel.text = "Social"

        recommendationLabel.text = "Recommendations"
    }

    private func styleNavigationBar() {
        navigationItem.titleView = UIImageView(image: .logo)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .backImage,
            style: .plain,
            target: navigationController,
            action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    private func makeCastMemberDataSource() -> CastMemberDataSource {
        CastMemberDataSource(collectionView: topBilledCastCollection) { (collectionView, indexPath, castMember)
            -> UICollectionViewCell? in
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CastMemberCell.cellIdentifier,
                    for: indexPath) as? CastMemberCell
            else {
                return UICollectionViewCell()
            }

            cell.setData(for: castMember)

            return cell
        }
    }

    private func makeRecommendationDataSource() -> RecommendationDataSource {
        RecommendationDataSource(collectionView: recommendationCollection) { (collectionView, indexPath, recommendation)
        -> UICollectionViewCell in
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieBackdropCell.cellIdentifier,
                    for: indexPath) as? MovieBackdropCell
            else {
                return UICollectionViewCell()
            }

            cell.setData(for: recommendation)

            cell.tapGesture()
                .sink { [weak self] _ in
                    self?.router?.showMovieDetails(for: recommendation.id)
                }
                .store(in: &cell.disposables)

            return cell
        }
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionView {
        case topBilledCastCollection:
            return CGSize(width: 125, height: 210)
        case recommendationCollection:
            return CGSize(width: 180, height: 120)
        default:
            return .zero
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 3 * spacing, bottom: 0, right: 3 * spacing)
    }

}

// MARK: UIScrollViewDelegate
extension MovieDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }

}
