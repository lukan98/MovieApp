import UIKit
import Combine

class MoviePosterView: UIView {

    let cornerRadius: CGFloat = 10
    let buttonSize = CGSize(width: 32, height: 32)

    var favoriteButton: UIButton!
    var posterImage: UIImageView!
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

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
    }

    func setData(id: Int, isFavorited: Bool) {
        movieId = id
        self.isFavorited = isFavorited
    }

    private func bindViews() {
        favoriteButton
            .tapGesture()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.favoritedToggleSubject.send(self.movieId)
            }
            .store(in: &disposables)
    }

}
