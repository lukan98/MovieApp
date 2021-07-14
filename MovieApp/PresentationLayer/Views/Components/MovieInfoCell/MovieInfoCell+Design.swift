import Foundation
import UIKit

extension MovieInfoCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        poster = UIImageView(image: UIImage())
        contentView.addSubview(poster)

        infoContainer = UIView()
        contentView.addSubview(infoContainer)

        name = UILabel()
        infoContainer.addSubview(name)

        about = UILabel()
        infoContainer.addSubview(about)
    }

    func styleViews() {
        backgroundColor = .red

        poster.backgroundColor = .yellow

        name.text = "Placeholder (2021)"
        name.backgroundColor = .blue

        about.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        about.backgroundColor = .green
    }

    func defineLayoutForViews() {
        poster.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(contentView.snp.leading).offset(posterWidth)
        }

        infoContainer.snp.makeConstraints {
            $0.leading.equalTo(poster.snp.trailing).offset(infoInset)
            $0.top.equalToSuperview().offset(infoInset)
            $0.trailing.bottom.equalToSuperview().offset(-infoInset)
        }

        name.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(infoContainer.snp.top).offset(20)
        }

        about.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

}
