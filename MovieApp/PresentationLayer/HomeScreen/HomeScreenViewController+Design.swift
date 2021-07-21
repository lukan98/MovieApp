import SnapKit
import UIKit

extension HomeScreenViewController: ConstructViewsProtocol {

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

        searchBar = SearchBar()
        view.addSubview(searchBar)

        optionView = OptionBar()
        view.addSubview(optionView)
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
            $0.height.equalTo(SearchBar.defaultHeight)
        }

        optionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

}
