import UIKit

class MoviePosterView: UIView {

    let cornerRadius: CGFloat = 10
    let buttonSize = CGSize(width: 32, height: 32)

    var onFavoriteToggle: (Int) -> Void = { _ in }

    var favoriteButton: UIButton!
    var posterImage: UIImageView!
    var movieId: Int!
    var isFavorited: Bool! {
        didSet {
            if isFavorited {
                favoriteButton.setImage(UIImage(named: "Favorites-fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "Favorites-outline"), for: .normal)
            }
        }
    }

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
    }

    func setData(for movie: MovieViewModel) {
        movieId = movie.id
        isFavorited = movie.isFavorited
    }

}
