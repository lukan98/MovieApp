import Foundation
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
        navigationView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        })
    }

}
