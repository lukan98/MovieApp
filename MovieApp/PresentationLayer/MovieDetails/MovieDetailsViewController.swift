import UIKit

class MovieDetailsViewController: UIViewController {

    let spacing: CGFloat = 5

    var navigationView: NavBarView!
    var headerView: MovieHeaderView!
    var overviewTitleLabel: UILabel!
    var overviewLabel: UILabel!

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
        setInitialData()
        loadData()
    }

    func loadData() {
        presenter.getMovieDetails { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movie):
                self.headerView.setData(for: movie)
                self.overviewLabel.text = movie.about
            case .failure:
                print("Failed to get movie details")
            }
        }

        presenter.getMovieCredits { result in

            switch result {
            case .success(let credits):
                print(credits.cast)
                print(credits.crew)
            case .failure:
                print("Failed to get movie credits")
            }
        }
    }

    private func setInitialData() {
        overviewTitleLabel.text = "Overview"
    }

}
