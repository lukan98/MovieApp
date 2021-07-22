import UIKit

extension CategoryCollection: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        title = UILabel()
        addSubview(title)

        options = OptionBar()
        addSubview(options)
        bringSubviewToFront(options)

        filmCollection = makeCollectionView()
        addSubview(filmCollection)
    }

    func styleViews() {
        title.text = "What's popular"
        title.font = UIFont(name: "ProximaNova-Bold", size: 20)
        title.textColor = UIColor(named: "DarkBlue")
    }

    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")

        return collectionView
    }

    func defineLayoutForViews() {
        title.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        options.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(spacing)
            $0.leading.trailing.equalToSuperview()
        }

        filmCollection.snp.makeConstraints {
            $0.top.equalTo(options.snp.bottom).offset(2*spacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }

}
