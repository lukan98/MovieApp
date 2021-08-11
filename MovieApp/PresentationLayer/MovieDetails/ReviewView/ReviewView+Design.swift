import UIKit
import SnapKit

extension ReviewView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        headerView = UIView()
        addSubview(headerView)

        titleLabel = UILabel()
        headerView.addSubview(titleLabel)

        subtitleLabel = UILabel()
        headerView.addSubview(subtitleLabel)

        dateLabel = UILabel()
        headerView.addSubview(dateLabel)

        avatarImageView = UIImageView()
        headerView.addSubview(avatarImageView)

        reviewLabel = UILabel()
        addSubview(reviewLabel)
    }

    func styleViews() {
        titleLabel.font = UIFont(name: "ProximaNova-Bold", size: 18)
        titleLabel.textColor = .black

        subtitleLabel.font = UIFont(name: "ProximaNova-Medium", size: 14)
        subtitleLabel.textColor = .black

        dateLabel.font = UIFont(name: "ProximaNova-Medium", size: 14)
        dateLabel.textColor = .black

        avatarImageView.contentMode = .scaleAspectFit

        reviewLabel.font = UIFont(name: "ProximaNova-Medium", size: 14)
        reviewLabel.textColor = .black
        reviewLabel.numberOfLines = 15
    }

    func defineLayoutForViews() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }

        avatarImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.lessThanOrEqualTo(CGSize(width: 60, height: 60))
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom)
            $0.leading.equalTo(subtitleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }

        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
