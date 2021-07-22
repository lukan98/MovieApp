import UIKit

class MoviePoster: UIView {

    let cornerRadius: CGFloat = 10
    let buttonSize: CGFloat = 32

    var favorited: Bool = false {
        didSet {
            if favorited {
                favoriteButton.setImage(UIImage(named: "Favorites-fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "Favorites-outline"), for: .normal)
            }
        }
    }
    var favoriteButton: UIButton!
    var posterImage: UIImageView!

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

}
