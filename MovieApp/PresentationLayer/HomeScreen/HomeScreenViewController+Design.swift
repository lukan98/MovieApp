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

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        stackView = UIStackView()
        scrollView.addSubview(stackView)

        for _ in 0...2 {
            stackView.addArrangedSubview(CategoryCollectionView())
        }
    }

    func styleViews() {
        view.backgroundColor = .white

        scrollView.showsVerticalScrollIndicator = false

        stackView.axis = .vertical
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

        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

}
