import UIKit

class MovieInfoCell: UICollectionViewCell {

    static let cellIdentifier = "movieInfoCell"

    var poster: UIImageView!
    var infoContainer: UIView!
    var name: UILabel!
    var about: UILabel!

    let infoInset: CGFloat = 15
    let posterWidth: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
