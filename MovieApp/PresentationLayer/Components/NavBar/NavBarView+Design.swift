import UIKit
import SnapKit

extension NavBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        backButton = UIImageView(image: .backImage)
        addSubview(backButton)

        backButton.isUserInteractionEnabled = true

        logo = UIImageView(image: .logo)
        addSubview(logo)
    }

    func styleViews() {
        backgroundColor = .darkBlue
        backButton.isHidden = true
    }

    func defineLayoutForViews() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(logo.snp.centerY)
            $0.height.equalTo(20)
        }

        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(38)
            $0.height.equalTo(35)
        }
    }

}
