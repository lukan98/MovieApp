import UIKit

class MovieDetailsViewController: UIViewController {

    var navigationView: NavBarView!
    var headerView: MovieHeaderView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private let presenter: MovieDetailsPresenter

    init(presenter: MovieDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        loadData()
    }

    func loadData() {
        presenter.getMovieDetails(for: 100) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movie):
                self.headerView.setData(for: movie)
            case .failure:
                print("ooops")
            }
        }
    }

}
