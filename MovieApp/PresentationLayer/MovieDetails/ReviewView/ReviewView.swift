import UIKit
import Kingfisher

class ReviewView: UIView {

    var headerView: UIView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var dateLabel: UILabel!
    var avatarImageView: UIImageView!
    var reviewLabel: UILabel!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarImageView.layoutIfNeeded()
        styleAvatar()
    }

    func setData(for review: ReviewViewModel) {
        titleLabel.text = "A review by \(review.author)"

        styleSubtitleLabel(for: review.author)

        dateLabel.text = review.date

        let imageUrl = URL(string: review.avatarSource)
        avatarImageView.kf.setImage(with: imageUrl)

        reviewLabel.text = review.review
    }

}
