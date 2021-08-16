import UIKit

enum ProximaNova: String {
    case medium = "ProximaNova-Medium"
    case semibold = "ProximaNova-Semibold"
    case bold = "ProximaNova-Bold"

    func of(size: CGFloat) -> UIFont {
        return UIFont(name: rawValue, size: size)!
    }
}
