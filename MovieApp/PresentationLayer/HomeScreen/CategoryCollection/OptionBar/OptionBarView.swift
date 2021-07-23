import UIKit

class OptionBarView: UIView {

    let placeholderData = ["Streaming", "On TV", "For Rent", "In theatres", "Showing near you"]

    var selectedCategoryIndex = 0
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

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

}
