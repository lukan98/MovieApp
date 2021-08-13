import UIKit

extension MovieBackdropCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        backdropImageView = UIImageView()
        addSubview(backdropImageView)

        titleLabel = UILabel()
        addSubview(titleLabel)
    }

    func styleViews() {
        backdropImageView.clipsToBounds = true
        backdropImageView.layer.cornerRadius = 10

        titleLabel.font = UIFont(name: "ProximaNova-Semibold", size: 16)
        titleLabel.textColor = UIColor(named: "DarkBlue")
    }

    func defineLayoutForViews() {
        backdropImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(85)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backdropImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

}