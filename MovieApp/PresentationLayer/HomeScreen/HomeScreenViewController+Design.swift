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

        searchBarView = SearchBarView()
        view.addSubview(searchBarView)

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        stackView = UIStackView()
        scrollView.addSubview(stackView)

        popularMoviesCollectionView = CategorisedCollectionView()
        stackView.addArrangedSubview(popularMoviesCollectionView)
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

        searchBarView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

}
