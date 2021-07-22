import UIKit

class NavBarView: UIView {

    static let defaultHeight = 80

    var backButton: UIImageView!
    var logo: UIImageView!

    var isBackButtonHidden = true {
        didSet {
            backButton.isHidden = isBackButtonHidden
        }
    }

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
