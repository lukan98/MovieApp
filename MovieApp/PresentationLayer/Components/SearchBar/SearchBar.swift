import UIKit

class SearchBar: UIStackView {

    static let defaultHeight = 40
    static let defaultSpacing: CGFloat = 20
    static let fontSize: CGFloat = 16

    var searchField: BaseSearchField!
    var cancelButton: UIButton!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
