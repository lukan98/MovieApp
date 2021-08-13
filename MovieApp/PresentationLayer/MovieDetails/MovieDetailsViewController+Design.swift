import UIKit
import SnapKit

extension MovieDetailsViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        navigationView = NavBarView()
        view.addSubview(navigationView)

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

        topBilledCastCollection = makeCollectionView()
        contentView.addSubview(topBilledCastCollection)

        socialLabel = UILabel()
        contentView.addSubview(socialLabel)

        reviewsContainerView = UIView()
        contentView.addSubview(reviewsContainerView)

        reviewsViewController = ReviewsViewController()
        addChild(reviewsViewController)

        reviewsContainerView.addSubview(reviewsViewController.view)
    }

    func styleViews() {
        view.backgroundColor = .white

        navigationView.isBackButtonHidden = false

        scrollView.delegate = self

        overviewTitleLabel.font = UIFont(name: "ProximaNova-Bold", size: 20)
        overviewTitleLabel.textColor = UIColor(named: "DarkBlue")

        overviewLabel.font = UIFont(name: "ProximaNova-Medium", size: 14)
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

        topBilledCastLabel.font = UIFont(name: "ProximaNova-Bold", size: 20)
        topBilledCastLabel.textColor = UIColor(named: "DarkBlue")

        topBilledCastCollection.backgroundColor = .white
        topBilledCastCollection.showsHorizontalScrollIndicator = false
        topBilledCastCollection.clipsToBounds = false

        socialLabel.font = UIFont(name: "ProximaNova-Bold", size: 20)
        socialLabel.textColor = UIColor(named: "DarkBlue")
    }

    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
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
            $0.bottom.equalToSuperview()
        }

        reviewsViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        reviewsViewController.didMove(toParent: self)
    }

    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CastMemberCell.self, forCellWithReuseIdentifier: CastMemberCell.cellIdentifier)

        return collectionView
    }

}
