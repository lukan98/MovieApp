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

        crewFirstRowStackView = UIStackView()
        crewGridView.addArrangedSubview(crewFirstRowStackView)

        for _ in 0...noOfCrewColumns-1 {
            crewFirstRowStackView.addArrangedSubview(CrewMemberLabelsView())
        }

        crewSecondRowStackView = UIStackView()
        crewGridView.addArrangedSubview(crewSecondRowStackView)

        for _ in 0...noOfCrewColumns-1 {
            crewSecondRowStackView.addArrangedSubview(CrewMemberLabelsView())
        }
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
        crewGridView.spacing = spacing

        crewFirstRowStackView.axis = .horizontal
        crewFirstRowStackView.distribution = .fillEqually

        crewSecondRowStackView.axis = .horizontal
        crewSecondRowStackView.distribution = .fillEqually
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

        crewFirstRowStackView.snp.makeConstraints {
            $0.height.equalTo(40)
        }

        crewSecondRowStackView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }

}
