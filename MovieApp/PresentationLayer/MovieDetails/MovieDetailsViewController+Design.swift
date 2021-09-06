import UIKit
import SnapKit

extension MovieDetailsViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        headerView = MovieHeaderView()
        contentView.addSubview(headerView)

        overviewTitleLabel = UILabel()
        contentView.addSubview(overviewTitleLabel)

        overviewLabel = UILabel()
        contentView.addSubview(overviewLabel)

        crewGridView = UIStackView()
        contentView.addSubview(crewGridView)

        crewGridRows = Array()
        for _ in 1...noOfCrewRows {
            let rowStackView = UIStackView()

            crewGridView.addArrangedSubview(rowStackView)
            crewGridRows.append(rowStackView)
        }

        crewMemberLabels = Array()
        for i in 0...noOfCrewColumns * noOfCrewRows - 1 {
            let row = i / noOfCrewColumns
            let stackView = crewGridRows.at(row)
            let labelsView = CrewMemberLabelsView()

            stackView?.addArrangedSubview(labelsView)
            crewMemberLabels.append(labelsView)
        }

        topBilledCastLabel = UILabel()
        contentView.addSubview(topBilledCastLabel)

        topBilledCastCollection = makeCastCollectionView()
        contentView.addSubview(topBilledCastCollection)

        socialLabel = UILabel()
        contentView.addSubview(socialLabel)

        reviewsContainerView = UIView()
        contentView.addSubview(reviewsContainerView)

        noReviewsLabel = UILabel()
        reviewsContainerView.addSubview(noReviewsLabel)
        noReviewsLabel.isHidden = true

        reviewsViewController = ReviewsViewController()
        addChild(reviewsViewController)

        reviewsContainerView.addSubview(reviewsViewController.view)

        recommendationLabel = UILabel()
        contentView.addSubview(recommendationLabel)

        recommendationCollection = makeRecommendationCollectionView()
        contentView.addSubview(recommendationCollection)
    }

    func styleViews() {
        view.backgroundColor = .white

        scrollView.delegate = self

        styleHeadingLabel(overviewTitleLabel)

        overviewLabel.font = ProximaNova.medium.of(size: 14)
        overviewLabel.textColor = .black
        overviewLabel.numberOfLines = 0

        crewGridView.axis = .vertical
        crewGridView.spacing = 5 * spacing

        for rowStackView in crewGridRows {
            rowStackView.axis = .horizontal
            rowStackView.alignment = .center
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = spacing
        }

        styleHeadingLabel(topBilledCastLabel)

        topBilledCastCollection.backgroundColor = .white
        topBilledCastCollection.showsHorizontalScrollIndicator = false
        topBilledCastCollection.clipsToBounds = false

        styleHeadingLabel(socialLabel)

        noReviewsLabel.font = ProximaNova.medium.of(size: 12)
        noReviewsLabel.textColor = .gray3
        noReviewsLabel.textAlignment = .center

        styleHeadingLabel(recommendationLabel)

        recommendationCollection.backgroundColor = .white
        recommendationCollection.showsHorizontalScrollIndicator = false
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }

        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(headerView.snp.width).multipliedBy(0.9)
        }

        overviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(4 * spacing)
            $0.leading.equalToSuperview().offset(4 * spacing)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * spacing)
        }

        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(overviewTitleLabel.snp.bottom).offset(2 * spacing)
            $0.leading.trailing.equalToSuperview().inset(4 * spacing)
        }

        crewGridView.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(5 * spacing)
            $0.leading.trailing.equalToSuperview().inset(4 * spacing)
        }

        for rowStackView in crewGridRows {
            rowStackView.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }

        topBilledCastLabel.snp.makeConstraints {
            $0.top.equalTo(crewGridView.snp.bottom).offset(8 * spacing)
            $0.leading.trailing.equalToSuperview().inset(4 * spacing)
        }

        topBilledCastCollection.snp.makeConstraints {
            $0.top.equalTo(topBilledCastLabel.snp.bottom).offset(spacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }

        socialLabel.snp.makeConstraints {
            $0.top.equalTo(topBilledCastCollection.snp.bottom).offset(4 * spacing)
            $0.leading.trailing.equalToSuperview().inset(4 * spacing)
        }

        reviewsContainerView.snp.makeConstraints {
            $0.top.equalTo(socialLabel.snp.bottom).offset(3 * spacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }

        noReviewsLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(2 * spacing)
        }

        reviewsViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        reviewsViewController.didMove(toParent: self)

        recommendationLabel.snp.makeConstraints {
            $0.top.equalTo(reviewsContainerView.snp.bottom).offset(3 * spacing)
            $0.leading.trailing.equalToSuperview().inset(4 * spacing)
        }

        recommendationCollection.snp.makeConstraints {
            $0.top.equalTo(recommendationLabel.snp.bottom).offset(spacing)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(140)
        }
    }

    private func styleHeadingLabel(_ label: UILabel) {
        label.font = ProximaNova.bold.of(size: 20)
        label.textColor = .darkBlue
    }

    private func makeCastCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CastMemberCell.self, forCellWithReuseIdentifier: CastMemberCell.cellIdentifier)

        return collectionView
    }

    private func makeRecommendationCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieBackdropCell.self, forCellWithReuseIdentifier: MovieBackdropCell.cellIdentifier)

        return collectionView
    }

}
