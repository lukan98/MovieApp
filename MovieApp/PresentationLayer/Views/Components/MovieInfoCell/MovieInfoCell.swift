import UIKit

class MovieInfoCell: UICollectionViewCell {

    static let cellIdentifier = "movieInfoCell"

    let infoInset: CGFloat = 15
    let posterWidth: CGFloat = 100
    let cornerRadius: CGFloat = 10
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

    func setData(for movie: Movie) {
        poster.image = UIImage(named: movie.posterSource)

        nameLabel.attributedText = NSMutableAttributedString(
            string: movie.name,
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        )

        aboutLabel.attributedText = NSMutableAttributedString(
            string: movie.about,
            attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 20
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowPath = UIBezierPath(rect: contentContainer.bounds).cgPath
    }

    

}
