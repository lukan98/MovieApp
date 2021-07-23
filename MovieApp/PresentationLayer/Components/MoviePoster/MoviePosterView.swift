import UIKit

class MoviePosterView: UIView {

    let cornerRadius: CGFloat = 10
    let buttonSize = CGSize(width: 32, height: 32)

    var isFavorited: Bool = false {
        didSet {
            if isFavorited {
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

    override func layoutSubviews() {
        super.layoutSubviews()

        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
    }

}
