import SnapKit
import UIKit

extension HomeScreenViewController: ConstructViewsProtocol {

    static let defaultHeight = 40

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        navigationView = NavBarView()
        view.addSubview(navigationView)

        searchBar = SearchBarView()
        view.addSubview(searchBar)

        categoryCollection = CategoryCollectionView()
        view.addSubview(categoryCollection)
    }

    func styleViews() {
        view.backgroundColor = .white
    }

    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        categoryCollection.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

}
