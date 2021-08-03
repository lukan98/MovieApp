import UIKit

extension CircularRatingView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        circleLayer = CAShapeLayer()
        ratingLayer = CAShapeLayer()

        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: radius, y: radius),
            radius: radius,
            startAngle: -.pi/2,
            endAngle: 3 * .pi/2,
            clockwise: true)

        circleLayer.path = circularPath.cgPath
        ratingLayer.path = circularPath.cgPath

        layer.addSublayer(circleLayer)
        layer.addSublayer(ratingLayer)

        ratingLabel = UILabel()
        addSubview(ratingLabel)
    }

    func styleViews() {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 3
        circleLayer.strokeColor = UIColor(named: "DarkGreen")?.cgColor

        ratingLayer.fillColor = UIColor.clear.cgColor
        ratingLayer.lineCap = .round
        ratingLayer.lineWidth = 3
        ratingLayer.strokeColor = UIColor(named: "LightGreen")?.cgColor

        styleRatingLabel()
    }

    func styleRatingLabel(for string: String = "%") {
        let numberAttributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNova-Bold", size: 15),
                                NSAttributedString.Key.foregroundColor: UIColor.white]
        let percentageAttributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNova-Bold", size: 9),
                                    NSAttributedString.Key.foregroundColor: UIColor.white]

        let percentageRange = NSString(string: string).range(of: "%")
        let attributedString = NSMutableAttributedString(
            string: string,
            attributes: numberAttributes as [NSAttributedString.Key : Any])
        attributedString.addAttributes(
            percentageAttributes as [NSAttributedString.Key : Any],
            range: percentageRange)
        ratingLabel.attributedText = attributedString
    }

    func defineLayoutForViews() {
        ratingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

}
