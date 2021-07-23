import UIKit

class BaseSearchTextField: UITextField {

    static let defaultSize = CGSize(width: 40, height: 40)

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        // super.leftViewRect not called because functionality needs to be overriden not extended
        CGRect(origin: .zero, size: BaseSearchTextField.defaultSize)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        // super.rightViewRect not called because functionality needs to be overriden not extended
        let dimension = BaseSearchTextField.defaultSize.height
        return CGRect(origin: CGPoint(x: bounds.maxX - CGFloat(dimension), y: 0), size: BaseSearchTextField.defaultSize)
    }

}
