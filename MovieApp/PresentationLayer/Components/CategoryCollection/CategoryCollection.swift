import UIKit

class CategoryCollection: UIView {

    let spacing = 10

    var title: UILabel!
    var options: OptionBar!
    var filmCollection: UICollectionView!

    init() {
        super.init(frame: .zero)

        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        defineLayoutForViews()
    }
    
}
