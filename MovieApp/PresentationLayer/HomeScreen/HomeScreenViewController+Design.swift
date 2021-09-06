import SnapKit
import UIKit

extension HomeScreenViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        searchBarView = SearchBarView()
        view.addSubview(searchBarView)

        searchedMoviesCollectionView = makeCollectionView()
        view.addSubview(searchedMoviesCollectionView)
        searchedMoviesCollectionView.isHidden = true

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        stackView = UIStackView()
        scrollView.addSubview(stackView)

        popularMoviesCollectionView = CategorisedCollectionView()
        stackView.addArrangedSubview(popularMoviesCollectionView)

        topRatedMoviesCollectionView = CategorisedCollectionView()
        stackView.addArrangedSubview(topRatedMoviesCollectionView)

        trendingMoviesCollectionView = CategorisedCollectionView()
        stackView.addArrangedSubview(trendingMoviesCollectionView)
    }

    func styleViews() {
        view.backgroundColor = .white

        searchedMoviesCollectionView.backgroundColor = .none

        scrollView.showsVerticalScrollIndicator = false

        stackView.axis = .vertical
    }

    func defineLayoutForViews() {
        searchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        searchedMoviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }

    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieInfoCell.self, forCellWithReuseIdentifier: MovieInfoCell.cellIdentifier)

        return collectionView
    }

}
