import UIKit

extension CategoryCollectionView: ConstructViewsProtocol {

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

        filmCollection.showsHorizontalScrollIndicator = false
    }

    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }

    func defineLayoutForViews() {
        title.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(defaultInset)
        }

        options.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(defaultInset)
        }

        filmCollection.snp.makeConstraints {
            $0.top.equalTo(options.snp.bottom).offset(2 * defaultSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
