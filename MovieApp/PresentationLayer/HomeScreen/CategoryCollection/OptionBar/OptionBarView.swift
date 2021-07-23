import UIKit

class OptionBarView: UIView {
    
    var selectedCategoryIndex = 0
    var scrollView: BaseScrollView!
    var contentView: UIView!
    var optionButtonStack: UIStackView!
    
    weak var categoryCollection: CategoryCollectionView!

    init(categoryCollection: CategoryCollectionView!) {
        super.init(frame: .zero)

        self.categoryCollection = categoryCollection
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
