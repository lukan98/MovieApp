import UIKit
import SnapKit

extension MovieHeaderView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        backgroundPosterView = UIImageView()
        addSubview(backgroundPosterView)

        gradientView = UIView()
        addSubview(gradientView)

        ratingView = CircularRatingView()
        addSubview(ratingView)

        userScoreLabel = UILabel()
        addSubview(userScoreLabel)

        titleLabel = UILabel()
        addSubview(titleLabel)

        releaseYearLabel = UILabel()
        addSubview(releaseYearLabel)

        releaseDateLabel = UILabel()
        addSubview(releaseDateLabel)

        genresLabel = UILabel()
        addSubview(genresLabel)

        runtimeLabel = UILabel()
        addSubview(runtimeLabel)

        favoriteButton = UIButton()
        addSubview(favoriteButton)
    }

    func styleViews() {
        backgroundPosterView.layer.masksToBounds = true
        backgroundPosterView.contentMode = .scaleAspectFill

        userScoreLabel.font = ProximaNova.bold.of(size: 14)
        userScoreLabel.textColor = .white

        titleLabel.font = ProximaNova.bold.of(size: 24)
        titleLabel.textColor = .white

        releaseYearLabel.font = ProximaNova.medium.of(size: 24)
        releaseYearLabel.textColor = .white

        releaseDateLabel.font = ProximaNova.medium.of(size: 14)
        releaseDateLabel.textColor = .white

        genresLabel.font = ProximaNova.medium.of(size: 14)
        genresLabel.textColor = .white

        runtimeLabel.font = ProximaNova.semibold.of(size: 14)
        runtimeLabel.textColor = .white

        favoriteButton.backgroundColor = .gray2.withAlphaComponent(0.6)
        favoriteButton.tintColor = .white
        favoriteButton.addTarget(self, action: #selector(onFavoriteTap), for: .touchUpInside)
    }

    func styleGradient() {
        gradientView.applyGradient(colors: [.white.withAlphaComponent(0), .black])
    }

    func styleButtonShape() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height * 0.5
    }

    func defineLayoutForViews() {
        backgroundPosterView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        gradientView.snp.makeConstraints {
            $0.edges.equalTo(backgroundPosterView)
        }

        favoriteButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(4 * spacing)
            $0.size.equalTo(buttonSize)
        }

        genresLabel.snp.makeConstraints {
            $0.leading.equalTo(favoriteButton)
            $0.bottom.equalTo(favoriteButton.snp.top).offset(-3 * spacing)
        }

        runtimeLabel.snp.makeConstraints {
            $0.leading.equalTo(genresLabel.snp.trailing).offset(spacing)
            $0.trailing.lessThanOrEqualToSuperview().inset(spacing)
            $0.centerY.equalTo(genresLabel)
        }

        releaseDateLabel.snp.makeConstraints {
            $0.bottom.equalTo(genresLabel.snp.top).offset(-spacing)
            $0.leading.equalTo(genresLabel)
            $0.trailing.lessThanOrEqualToSuperview().inset(spacing)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(releaseDateLabel)
            $0.bottom.equalTo(releaseDateLabel.snp.top).offset(-2 * spacing)
        }

        releaseYearLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(spacing)
            $0.trailing.lessThanOrEqualToSuperview().inset(spacing)
            $0.bottom.equalTo(titleLabel)
        }

        ratingView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-3 * spacing)
        }

        userScoreLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingView.snp.trailing).offset(spacing)
            $0.trailing.equalToSuperview().inset(spacing)
            $0.centerY.equalTo(ratingView)
        }
    }

    @objc
    private func onFavoriteTap() {
        onFavoriteToggle(movieId)
    }

}
