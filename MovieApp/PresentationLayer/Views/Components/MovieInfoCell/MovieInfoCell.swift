import UIKit

class MovieInfoCell: UICollectionViewCell {

    static let cellIdentifier = "movieInfoCell"

    var contentContainer: UIView!
    var posterSource: String = "IronMan1"
    var poster: UIImageView!
    var infoContainer: UIView!
    var nameString: String = "Iron Man (2008)"
    var nameLabel: UILabel!
    var aboutString: String = "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
    var aboutLabel: UILabel!

    let infoInset: CGFloat = 15
    let posterWidth: CGFloat = 100
    let cornerRadius: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.shadowOffset = CGSize(width: 4, height: 20)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.red.cgColor
        contentView.layer.shadowPath = UIBezierPath(rect: contentContainer.bounds).cgPath
    }

    

}
