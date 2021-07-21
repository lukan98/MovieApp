import UIKit

class BaseSearchField: UITextField {

    static let defaultHeight = 40

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: 0, y: 0, width: BaseSearchField.defaultHeight, height: BaseSearchField.defaultHeight)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let dimension = BaseSearchField.defaultHeight
        return CGRect(x: Int(bounds.maxX) - dimension, y: 0, width: dimension, height: dimension)
    }

}
