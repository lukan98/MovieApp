import UIKit

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
    var reviewsContainerView: UIView!
    var reviewsViewController: ReviewsViewController!
    var recommendationLabel: UILabel!
    var recommendationCollection: UICollectionView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private let presenter: MovieDetailsPresenter

    init(presenter: MovieDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        setInitialData()
        loadData()
    }

    func loadData() {
        presenter.getMovieDetails { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movie):
                self.headerView.setData(for: movie)
                self.overviewLabel.text = movie.about
            case .failure:
                print("Failed to get movie details")
            }
        }

        presenter.getMovieCredits(maximumCrewMembers: noOfCrewRows * noOfCrewColumns) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let credits):
                self.setCrewGridData(for: credits.crew)
                self.castMembers = credits.cast
                self.topBilledCastCollection.reloadData()
            case .failure:
                print("Failed to get movie credits")
            }
        }

        presenter.getReview { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let reviewViewModels):
                self.setReviewData(for: reviewViewModels)
            case .failure:
                print("Failed to get movie reviews")
            }
        }

        presenter.getRecommendations { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let recommendationViewModels):
                self.recommendations = recommendationViewModels
                self.recommendationCollection.reloadData()
            case .failure:
                print("Failed to get movie recommendations")
            }
        }
    }

    private func setInitialData() {
        overviewTitleLabel.text = "Overview"

        topBilledCastLabel.text = "Top Billed Cast"

        socialLabel.text = "Social"

        recommendationLabel.text = "Recommendations"
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

    private func setReviewData(for reviews: [ReviewViewModel]) {
        reviewsViewController.setData(for: reviews)
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
