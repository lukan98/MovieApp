import UIKit

extension FavoritesViewController: ConstructViewsProtocol {

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

        favoritesLabel = UILabel()
        view.addSubview(favoritesLabel)

        movieCollectionView = makeCollectionView()
        view.addSubview(movieCollectionView)
    }

    func styleViews() {
        view.backgroundColor = .white

        favoritesLabel.font = ProximaNova.bold.of(size: 20)
        favoritesLabel.textColor = .darkBlue
        favoritesLabel.text = "Favorites"

        movieCollectionView.backgroundColor = .white
        movieCollectionView.showsVerticalScrollIndicator = false

    }

    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }

        favoritesLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }

        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(favoritesLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }

}
