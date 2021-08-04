import UIKit
import Kingfisher

class MovieHeaderView: UIView {

    let spacing = 5
    let buttonSize = CGSize(width: 32, height: 32)

    var backgroundPosterView: UIImageView!
    var gradientView: UIView!
    var titleLabel: UILabel!
    var releaseYearLabel: UILabel!
    var releaseDateLabel: UILabel!
    var genresLabel: UILabel!
    var runtimeLabel: UILabel!
    var favoriteButton: UIButton!
    var isFavorited: Bool! {
        didSet {
            if isFavorited {
                favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
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

    override func layoutSubviews() {
        super.layoutSubviews()

        styleGradient()
        styleButtonShape()
    }

    func setData(for movie: DetailedMovieViewModel) {
        let imageUrl = URL(string: movie.posterSource)
        backgroundPosterView.kf.setImage(with: imageUrl)

        titleLabel.text = movie.name
        releaseYearLabel.text = movie.releaseYear
        releaseDateLabel.text = movie.releaseDate
        genresLabel.text = movie.genres
        runtimeLabel.text = movie.runtime

        isFavorited = movie.isFavorited
    }

}
