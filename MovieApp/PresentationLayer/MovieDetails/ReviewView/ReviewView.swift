import UIKit
import Kingfisher

class ReviewView: UIView {

    let spacing = 5
    let numberOfLines = 15

    var headerView: UIView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var dateLabel: UILabel!
    var avatarImageView: UIImageView!
    var reviewLabel: UILabel!

    private var reviewText: String = ""

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

        reviewText = review.review
        reviewLabel.text = review.review
        reviewLabel.addTrailing(
            with: "... ",
            appendageText: "read the rest",
            appendageFont: UIFont(name: "ProximaNova-Medium", size: 14),
            appendageColor: UIColor(named: "DarkBlue"))
    }

    func expandCollapseReview() {
        if reviewText != reviewLabel.text {
            reviewLabel.text = reviewText
        } else {
            reviewLabel.addTrailing(
                with: "... ",
                appendageText: "read the rest",
                appendageFont: UIFont(name: "ProximaNova-Medium", size: 14),
                appendageColor: UIColor(named: "DarkBlue"))
        }
    }

}
