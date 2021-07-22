import UIKit

class FavoritesViewController: UIViewController {

    var navigationView: NavBarView!
    var moviePoster: MoviePoster!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        moviePoster.roundButton()
    }

}
