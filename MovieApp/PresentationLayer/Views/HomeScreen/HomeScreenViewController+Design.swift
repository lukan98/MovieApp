import SnapKit
import UIKit

extension HomeScreenViewController: ConstructViewsProtocol {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        navigationView = NavBarView()
        view.addSubview(navigationView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }
    }

}
