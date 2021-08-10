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

        headerView = MovieHeaderView()
        view.addSubview(headerView)

        overviewTitleLabel = UILabel()
        view.addSubview(overviewTitleLabel)

        overviewLabel = UILabel()
        view.addSubview(overviewLabel)

        crewGridView = UIStackView()
        view.addSubview(crewGridView)

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

        topBilledCastCollection = makeCollectionView()
        view.addSubview(topBilledCastCollection)
    }

    func styleViews() {
        view.backgroundColor = .white

        navigationView.isBackButtonHidden = false

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

        topBilledCastCollection.backgroundColor = .white
        topBilledCastCollection.showsHorizontalScrollIndicator = false
        topBilledCastCollection.clipsToBounds = false
    }

    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }

        headerView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
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

        topBilledCastCollection.snp.makeConstraints {
            $0.top.equalTo(crewGridView.snp.bottom).offset(spacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }

    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.cellIdentifier)

        return collectionView
    }

}
