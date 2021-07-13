import UIKit
import SnapKit

class NavBarView: UIView {

    static let defaultHeight = 80
    private var backButton: UIImageView!
    private var logo: UIImageView!

    var isBackButtonHidden = true {
        didSet {
            backButton.isHidden = isBackButtonHidden
        }
    }

    init() {
        super.init(frame: CGRect())
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension NavBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        backButton = UIImageView(image: UIImage(named: "BackButton"))
        self.addSubview(backButton)
        logo = UIImageView(image: UIImage(named: "TMDBLogo"))
        self.addSubview(logo)
    }

    func styleViews() {
        backgroundColor = UIColor(named: "DarkBlue")
        backButton.isHidden = true
    }

    func defineLayoutForViews() {
        backButton.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(logo.snp.centerY)
            $0.height.equalTo(20)
        })

        logo.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(38)
            $0.height.equalTo(35)
        })
    }

}
