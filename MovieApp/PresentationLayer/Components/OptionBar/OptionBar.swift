import UIKit

class OptionBar: UIView {

    var currentlySelectedCategory = 0
    var scrollView: UIScrollView!
    var contentView: UIView!
    var optionButtonStack: UIStackView!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
