import UIKit

class CircularRatingView: UIView {

    let radius: CGFloat = 21
    let lineThickness: CGFloat = 3

    var size: CGSize {
        CGSize(width: radius * 2, height: radius * 2)
    }

    var circleLayer: CAShapeLayer!
    var ratingLayer: CAShapeLayer!
    var ratingLabel: UILabel!
    var ratingContainer: UIView!
    var numberLabel: UILabel!
    var percentageLabel: UILabel!

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
        guard rating >= 0, rating <= 10
        else {
            return
        }

        styleRatingLabel(for: String(format: "%.0f", rating * 10) + "%")
        ratingAnimation(rating: rating / 10, duration: 0.5)
    }

}
