import UIKit

class CircularRatingView: UIView {

    let radius: CGFloat = 21
    let lineThickness: CGFloat = 3
    let maximumRating: Double = 10
    let minimumRating: Double = 0

    var rating: Double?
    var circleLayer: CAShapeLayer!
    var ratingLayer: CAShapeLayer!
    var ratingLabel: UILabel!
    var ratingContainer: UIView!
    var numberLabel: UILabel!
    var percentageLabel: UILabel!

    var size: CGSize {
        CGSize(width: radius * 2, height: radius * 2)
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 2 * radius, height: 2 * radius)
    }

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(for rating: Double) {
        guard
            rating >= minimumRating,
            rating <= maximumRating
        else {
            return
        }

        styleRatingLabel(for: String(Int(rating / maximumRating * 100)) + "%")
        if self.rating == nil {
            ratingAnimation(rating: rating / maximumRating, duration: 0.5)
            self.rating = rating
        }
    }

}
