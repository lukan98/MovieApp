import UIKit

class SearchBarView: UIView {

    static let defaultHeight = 40
    static let defaultSpacing: CGFloat = 20
    static let fontSize: CGFloat = 16

    var onCancelTapped: () -> Void = {}

    var stackView: UIStackView!
    var searchField: BaseSearchTextField!
    var cancelButton: UIButton!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

}
