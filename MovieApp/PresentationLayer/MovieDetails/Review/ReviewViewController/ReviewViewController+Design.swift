extension ReviewViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        reviewView = ReviewView()
        view.addSubview(reviewView)
    }

    func styleViews() {
    }

    func defineLayoutForViews() {
        reviewView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(4 * spacing)
        }
    }

}
