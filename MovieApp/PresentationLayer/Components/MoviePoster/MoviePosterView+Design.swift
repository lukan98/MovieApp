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
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        addSubview(favoriteButton)

        bringSubviewToFront(favoriteButton)
    }

    func styleViews() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true

        favoriteButton.backgroundColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.6)
        favoriteButton.tintColor = .white
        favoriteButton.setImage(UIImage(named: "Favorites-outline"), for: .normal)
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

    @objc
    func toggleFavorite() {
        onFavoriteToggle(movieId)
    }

}
