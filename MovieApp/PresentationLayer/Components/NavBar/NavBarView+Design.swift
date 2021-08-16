import UIKit
import SnapKit

extension NavBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        backButton = UIImageView(image: UIImage(named: "BackButton"))
        addSubview(backButton)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.addGestureRecognizer(tapGestureRecognizer)
        backButton.isUserInteractionEnabled = true

        logo = UIImageView(image: UIImage(named: "TMDBLogo"))
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

    @objc
    private func backButtonTapped(_ sender: UITapGestureRecognizer) {
        onBackButtonTap()
    }

}
