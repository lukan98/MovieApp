extension MoviePosterCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        moviePoster = MoviePoster()
        addSubview(moviePoster)
    }

    func styleViews() {
    }

    func defineLayoutForViews() {
        moviePoster.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
