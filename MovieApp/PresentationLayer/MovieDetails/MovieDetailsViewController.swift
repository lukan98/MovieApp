import UIKit

class MovieDetailsViewController: UIViewController {

    let spacing: CGFloat = 5
    let noOfCrewRows = 1
    let noOfCrewColumns = 3

    var navigationView: NavBarView!
    var headerView: MovieHeaderView!
    var crewGridView: UIStackView!
    var crewGridRows: [UIStackView]!
    var crewMemberLabels: [CrewMemberLabelsView]!
    var overviewTitleLabel: UILabel!
    var overviewLabel: UILabel!
    var topBilledCastLabel: UILabel!
    var topBilledCastCollection: UICollectionView!

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
            case .failure:
                print("Failed to get movie credits")
            }
        }
    }

    private func setInitialData() {
        overviewTitleLabel.text = "Overview"
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

}

// MARK: UICollectionViewDataSource
extension MovieDetailsViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.castMembers.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = topBilledCastCollection.dequeueReusableCell(
                withReuseIdentifier: CastMemberCell.cellIdentifier,
                for: indexPath) as? CastMemberCell,
            let castMember = presenter.castMembers.at(indexPath.item)
        else {
            return CastMemberCell()
        }

        cell.setData(for: castMember)
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
        CGSize(width: 125, height: 210)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 3 * spacing, bottom: 0, right: 3 * spacing)
    }

}
