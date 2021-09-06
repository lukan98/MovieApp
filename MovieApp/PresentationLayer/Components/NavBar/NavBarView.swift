import UIKit
import Combine

class NavBarView: UIView {

    static let defaultHeight = 80

    var isBackButtonHidden = true {
        didSet {
            backButton.isHidden = isBackButtonHidden
        }
    }

    var backButton: UIImageView!
    var logo: UIImageView!
    var backButtonTapped: AnyPublisher<GestureType, Never> {
        backButton
            .tapGesture()
            .eraseToAnyPublisher()
    }

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
