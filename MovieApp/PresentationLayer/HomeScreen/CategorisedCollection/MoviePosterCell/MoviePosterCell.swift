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

    func setData(id: Int, isFavorited: Bool, posterSource: String) {
        moviePoster.setData(id: id, isFavorited: isFavorited)
        let imageUrl = URL(string: posterSource)
        moviePoster.posterImage.kf.setImage(with: imageUrl)
    }
    
}
