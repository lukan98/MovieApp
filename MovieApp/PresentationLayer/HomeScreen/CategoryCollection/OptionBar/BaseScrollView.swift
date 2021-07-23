import UIKit

class BaseScrollView: UIScrollView {

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIButton.self) {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }

}
