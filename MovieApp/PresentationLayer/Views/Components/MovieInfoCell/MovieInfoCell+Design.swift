import Foundation
import UIKit

extension MovieInfoCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        contentContainer = UIView()
        contentView.addSubview(contentContainer)

        poster = UIImageView(image: UIImage(named: posterSource))
        contentContainer.addSubview(poster)

        infoContainer = UIView()
        contentContainer.addSubview(infoContainer)

        nameLabel = UILabel()
        infoContainer.addSubview(nameLabel)

        aboutLabel = UILabel()
        infoContainer.addSubview(aboutLabel)
    }

    func styleViews() {
        styleCell()
        styleContents()
    }

    private func styleCell() {


        
        contentContainer.layer.cornerRadius = cornerRadius
        contentContainer.layer.borderWidth = 1
        contentContainer.layer.borderColor = UIColor.black.cgColor
        contentContainer.clipsToBounds = true
    }

    private func styleContents() {
        nameLabel.attributedText = NSAttributedString(
            string: nameString,
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        )

        aboutLabel.attributedText = NSAttributedString(
            string: aboutString,
            attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        )
        aboutLabel.numberOfLines = 0
    }

    func defineLayoutForViews() {
        contentContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }

        poster.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(posterWidth)
        }

        infoContainer.snp.makeConstraints {
            $0.leading.equalTo(poster.snp.trailing).offset(infoInset)
            $0.top.equalToSuperview().offset(infoInset)
            $0.trailing.bottom.equalToSuperview().offset(-infoInset)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        aboutLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

}
