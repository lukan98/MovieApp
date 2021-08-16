import UIKit
import Kingfisher

class ReviewView: UIView {

    let spacing = 5

    var headerView: UIView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var dateLabel: UILabel!
    var avatarImageView: UIImageView!
    var reviewLabel: UILabel!

    var reviewText: String = ""

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
        titleLabel.text = "A review by \(review.authorName)"

        styleSubtitleLabel(for: review.authorName)

        dateLabel.text = review.date

        let imageUrl = URL(string: review.avatarPath)
        avatarImageView.kf.setImage(with: imageUrl)

        reviewText = review.content
        reviewLabel.text = review.content
    }

    func truncateReviewText() {
        reviewLabel.addTrailing(
            with: "... ",
            appendageText: "read the rest",
            appendageFont: ProximaNova.medium.of(size: 14),
            appendageColor: UIColor(named: "DarkBlue"))
    }

    func expandCollapseReview() {
        if reviewText != reviewLabel.text {
            reviewLabel.text = reviewText
        } else {
            truncateReviewText()
        }
    }

}
