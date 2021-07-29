import UIKit
import Kingfisher

class MoviePosterCell: UICollectionViewCell {

    static let cellIdentifier = String(describing: MoviePosterCell.self)

    var moviePoster: MoviePosterView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        defineLayoutForViews()
    }

    func setData(for movie: MovieViewModel) {
        moviePoster.setData(for: movie)
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w154" + movie.posterSource)
        moviePoster.posterImage.kf.setImage(with: imageUrl)
    }
}
