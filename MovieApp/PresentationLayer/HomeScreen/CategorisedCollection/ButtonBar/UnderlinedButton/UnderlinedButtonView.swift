import UIKit

class UnderlinedButtonView: UIView {

    let underlineThickness = 3

    let title: String

    var button: UIButton!
    var underline: UIView!

    init(title: String) {
        self.title = title
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

    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
}
