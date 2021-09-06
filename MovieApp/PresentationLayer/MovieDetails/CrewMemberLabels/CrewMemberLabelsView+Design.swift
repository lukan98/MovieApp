import UIKit

extension CrewMemberLabelsView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        nameLabel = UILabel()
        addSubview(nameLabel)

        jobLabel = UILabel()
        addSubview(jobLabel)
    }

    func styleViews() {
        nameLabel.font = ProximaNova.bold.of(size: fontSize)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0

        jobLabel.font = ProximaNova.medium.of(size: fontSize)
        jobLabel.textColor = .black
        jobLabel.numberOfLines = 0
    }

    func defineLayoutForViews() {
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }

        jobLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(spacing)
        }
    }

}
