import UIKit
import Kingfisher
import Combine

class MovieBackdropCell: UICollectionViewCell {

    static let cellIdentifier = String(describing: MovieBackdropCell.self)

    var disposables = Set<AnyCancellable>()

    var backdropImageView: UIImageView!
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        self.prepareForReuse()

        disposables = []
    }

    func setData(for movie: MovieRecommendationViewModel) {
        let imageUrl = URL(string: movie.backdropPath)
        backdropImageView.kf.setImage(with: imageUrl)

        titleLabel.text = movie.title
    }

}
