import UIKit

extension MoviePosterView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        posterImage = UIImageView()
        addSubview(posterImage)

        favoriteButton = UIButton()
        addSubview(favoriteButton)

        bringSubviewToFront(favoriteButton)
    }

    func styleViews() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true

        favoriteButton.backgroundColor = .darkBlue.withAlphaComponent(0.6)
        favoriteButton.tintColor = .white
        favoriteButton.setImage(.favoritesOutlined, for: .normal)
    }

    func defineLayoutForViews() {
        posterImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        favoriteButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.size.equalTo(buttonSize)
        }
    }
    
}
