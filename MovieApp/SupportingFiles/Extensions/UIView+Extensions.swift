import UIKit

extension UIView {

    func applyGradient(colors: [UIColor]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        layer.insertSublayer(gradient, at: 0)
    }

}
