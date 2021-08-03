import SnapKit

extension MovieDetailsViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        navigationView = NavBarView()
        view.addSubview(navigationView)

        headerView = MovieHeaderView()
        view.addSubview(headerView)
    }

    func styleViews() {
        view.backgroundColor = .white

        navigationView.isBackButtonHidden = false
    }

    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }

        headerView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(headerView.snp.width).multipliedBy(0.9)
        }
    }

}
