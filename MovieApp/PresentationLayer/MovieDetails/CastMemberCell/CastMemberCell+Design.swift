import UIKit
import SnapKit

extension CastMemberCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        profileImageView = UIImageView()
        contentView.addSubview(profileImageView)

        castMemberNameLabel = UILabel()
        contentView.addSubview(castMemberNameLabel)

        characterNameLabel = UILabel()
        contentView.addSubview(characterNameLabel)
    }

    func styleViews() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true

        castMemberNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 14)
        castMemberNameLabel.numberOfLines = 2

        characterNameLabel.font = UIFont(name: "ProximaNova-Medium", size: 12)
        characterNameLabel.numberOfLines = 2
    }

    func defineLayoutForViews() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }

        castMemberNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(profileImageView.snp.bottom).offset(spacing)
        }

        characterNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(castMemberNameLabel)
            $0.top.greaterThanOrEqualTo(castMemberNameLabel.snp.bottom)
            $0.bottom.lessThanOrEqualToSuperview().inset(2 * spacing)
        }
    }

}
