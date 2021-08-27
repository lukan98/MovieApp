import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    
    let spacing: CGFloat = 5
    let noOfCrewRows = 3
    let noOfCrewColumns = 3
    
    var castMembers: [CastMemberViewModel] = []
    var recommendations: [MovieRecommendationViewModel] = []
    
    var navigationView: NavBarView!
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
    
    private let movieId: Int
    private let presenter: MovieDetailsPresenter
    
    private var disposables = Set<AnyCancellable>()
    
    private weak var router: MovieDetailsRouterProtocol?
    
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
        
        buildViews()
        bindViews()
        setInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func bindViews() {
        navigationView
            .backButtonTapped
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.router?.goBack()
            }
            .store(in: &disposables)

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
                    guard let self = self else { return }
                    
                    self.setMovieDetailsData(for: detailedMovieViewModel)
                })
            .store(in: &disposables)
        
        presenter
            .credits(for: movieId, maxCrewMembers: noOfCrewRows * noOfCrewColumns)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] creditsViewModel in
                    guard let self = self else { return }

                    self.setCreditsData(for: creditsViewModel)
                })
            .store(in: &disposables)

        presenter
            .reviews(for: movieId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] reviewViewModels in
                    guard let self = self else { return }

                    self.setReviewData(for: reviewViewModels)
                })
            .store(in: &disposables)

        presenter
            .recommendations(basedOn: movieId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] recommendationViewModels in
                    guard let self = self else { return }

                    self.setRecommendationData(for: recommendationViewModels)
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
        castMembers = credits.cast
        topBilledCastCollection.reloadData()
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
        self.recommendations = recommendations
        recommendationCollection.reloadData()
    }
    
    private func setInitialData() {
        overviewTitleLabel.text = "Overview"
        
        topBilledCastLabel.text = "Top Billed Cast"
        
        socialLabel.text = "Social"
        
        recommendationLabel.text = "Recommendations"
    }
    
}

// MARK: UICollectionViewDataSource
extension MovieDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch collectionView {
        case topBilledCastCollection:
            return castMembers.count
        case recommendationCollection:
            return recommendations.count
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard collectionView == recommendationCollection,
              let movie = recommendations.at(indexPath.row)
        else {
            return
        }
        
        router?.showMovieDetails(for: movie.id)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView {
        case topBilledCastCollection:
            return topBilledCastCollection(cellForItemAt: indexPath)
        case recommendationCollection:
            return recommendationCollection(cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func topBilledCastCollection(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = topBilledCastCollection.dequeueReusableCell(
                withReuseIdentifier: CastMemberCell.cellIdentifier,
                for: indexPath) as? CastMemberCell,
            let castMember = castMembers.at(indexPath.item)
        else {
            return CastMemberCell()
        }
        
        cell.setData(for: castMember)
        return cell
    }
    
    private func recommendationCollection(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = recommendationCollection.dequeueReusableCell(
                withReuseIdentifier: MovieBackdropCell.cellIdentifier,
                for: indexPath) as? MovieBackdropCell,
            let recommendation = recommendations.at(indexPath.item)
        else {
            return MovieBackdropCell()
        }
        
        cell.setData(for: recommendation)
        return cell
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
