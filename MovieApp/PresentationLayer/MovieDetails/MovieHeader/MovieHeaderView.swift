import UIKit
import Kingfisher
import Combine

class MovieHeaderView: UIView {

    let spacing = 5
    let buttonSize = CGSize(width: 32, height: 32)

    var backgroundPosterView: UIImageView!
    var gradientView: UIView!
    var ratingView: CircularRatingView!
    var userScoreLabel: UILabel!
    var titleLabel: UILabel!
    var releaseYearLabel: UILabel!
    var releaseDateLabel: UILabel!
    var genresLabel: UILabel!
    var runtimeLabel: UILabel!
    var favoriteButton: UIButton!
    var movieId: Int!
    var isFavorited: Bool! {
        didSet {
            if isFavorited {
                favoriteButton.setImage(.favoritesFilled, for: .normal)
            } else {
                favoriteButton.setImage(.favoritesOutlined, for: .normal)
            }
        }
    }
    var favoritedToggle: AnyPublisher<Int, Error> {
        favoritedToggleSubject
            .eraseToAnyPublisher()
    }

    private let favoritedToggleSubject = PassthroughSubject<Int, Error>()

    private var disposables = Set<AnyCancellable>()

    init() {
        super.init(frame: .zero)

        buildViews()
        bindViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        styleGradient()
        styleButtonShape()
    }

    func setData(for movie: DetailedMovieViewModel) {
        let imageUrl = URL(string: movie.posterSource)
        backgroundPosterView.kf.setImage(with: imageUrl)

        userScoreLabel.text = "User Score"
        titleLabel.text = movie.name
        releaseYearLabel.text = movie.releaseYear
        releaseDateLabel.text = movie.releaseDate
        genresLabel.text = movie.genres
        runtimeLabel.text = movie.runtime

        isFavorited = movie.isFavorited
        movieId = movie.id

        ratingView.setData(for: movie.voteAverage)
    }

    private func bindViews() {
        favoriteButton
            .throttledTapGesture()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.favoritedToggleSubject.send(self.movieId)
            }
            .store(in: &disposables)
    }

}
