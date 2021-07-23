import UIKit

extension CategoryCollectionView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        title = UILabel()
        addSubview(title)

        options = OptionBarView(categoryCollection: self)
        addSubview(options)
        bringSubviewToFront(options)

        movieCollection = makeCollectionView()
        addSubview(movieCollection)
    }

    func styleViews() {
        title.font = UIFont(name: "ProximaNova-Bold", size: 20)
        title.textColor = UIColor(named: "DarkBlue")

        movieCollection.showsHorizontalScrollIndicator = false
    }

    func defineLayoutForViews() {
        title.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(defaultInset)
        }

        options.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(defaultInset)
        }

        movieCollection.snp.makeConstraints {
            $0.top.equalTo(options.snp.bottom).offset(2 * defaultSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(180 + defaultInset)
        }
    }

    func reloadData() {
        UIView.animate(
            withDuration: 0.4,
            animations: {
                self.movieCollection.alpha = 0.5
                self.movieCollection.reloadData()
                self.movieCollection.setContentOffset(.zero, animated: true)
                self.movieCollection.alpha = 1
            })
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

}
