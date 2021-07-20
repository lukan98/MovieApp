import SnapKit
import UIKit

extension HomeScreenViewController: ConstructViewsProtocol {

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

        movieCollection = createCollectionView()
        view.addSubview(movieCollection)
    }

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieInfoCell.self, forCellWithReuseIdentifier: MovieInfoCell.cellIdentifier)

        return collectionView
    }
    
    func styleViews() {
        view.backgroundColor = .white

        movieCollection.backgroundColor = .none
    }
    
    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalTo(NavBarView.defaultHeight)
        }
        
        movieCollection.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
