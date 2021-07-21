import UIKit

class BaseSearchField: UITextField {

    static let defaultSize = CGSize(width: 40, height: 40)

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(origin: .zero, size: BaseSearchField.defaultSize)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let dimension = BaseSearchField.defaultSize.height
        return CGRect(origin: CGPoint(x: bounds.maxX - CGFloat(dimension), y: 0), size: BaseSearchField.defaultSize)
    }

}
