import UIKit

extension FavoritesViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
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
        favoritesLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(spacing)
        }

        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(favoritesLabel.snp.bottom).offset(spacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
