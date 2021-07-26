import UIKit

class ButtonBarView: UIView {
    
    var selectedButtonIndex = 0
    var scrollView: BaseScrollView!
    var contentView: UIView!
    var buttonStack: UIStackView!

    var onButtonSelected: (Int) -> Void = { _ in }

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

}
