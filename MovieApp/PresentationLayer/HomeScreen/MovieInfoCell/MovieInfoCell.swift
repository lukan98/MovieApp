import UIKit
import Kingfisher
import Combine

class MovieInfoCell: UICollectionViewCell {

    static let cellIdentifier = String(describing: MovieInfoCell.self)

    let infoInset: CGFloat = 15
    let posterWidth: CGFloat = 100
    let cornerRadius: CGFloat = 10

    var disposables = Set<AnyCancellable>()

    var contentContainer: UIView!
    var poster: UIImageView!
    var infoContainer: UIView!
    var nameLabel: UILabel!
    var aboutLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 20
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowPath = UIBezierPath(rect: contentContainer.bounds).cgPath
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposables = []
    }

    func setData(for movie: MovieViewModel) {
        poster.kf.setImage(with: URL(string: movie.posterSource))

        nameLabel.text = movie.name

        aboutLabel.text = movie.about
    }

}
