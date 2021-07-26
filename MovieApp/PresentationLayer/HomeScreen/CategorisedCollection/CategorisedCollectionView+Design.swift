import UIKit

extension CategorisedCollectionView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)

        optionsView = ButtonBarView()
        addSubview(optionsView)
        bringSubviewToFront(optionsView)

        movieCollectionView = makeCollectionView()
        addSubview(movieCollectionView)
    }

    func styleViews() {
        titleLabel.font = UIFont(name: "ProximaNova-Bold", size: 20)
        titleLabel.textColor = UIColor(named: "DarkBlue")

        movieCollectionView.showsHorizontalScrollIndicator = false
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(defaultInset)
        }

        optionsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(defaultInset)
        }

        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(optionsView.snp.bottom).offset(2 * defaultSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(180 + defaultInset)
        }
    }

    func animatedDataReload() {
        UIView.animate(
            withDuration: 0.4,
            animations: {
                self.movieCollectionView.alpha = 0.5
                self.movieCollectionView.reloadData()
                self.movieCollectionView.setContentOffset(.zero, animated: true)
                self.movieCollectionView.alpha = 1
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
