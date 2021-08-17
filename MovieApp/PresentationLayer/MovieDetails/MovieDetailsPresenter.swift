import Foundation

class MovieDetailsPresenter {

    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieViewModel, RequestError>) -> Void
    ) {
        useCase.getMovieDetails(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { DetailedMovieViewModel(from: $0) } )
            }
        }
    }

    func getMovieCredits(
        for movieId: Int,
        maximumCrewMembers max: Int,
        _ completionHandler: @escaping (Result<CreditsViewModel, RequestError>) -> Void
    ) {
        useCase.getMovieCredits(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { CreditsViewModel(from: $0).sortAndSliceCrew(first: max) } )
            }
        }
    }

    func getReview(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewViewModel], RequestError>) -> Void
    ) {
        useCase.getMovieReviews(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { ReviewViewModel(from: $0)}})
            }
        }
    }

    func getRecommendations(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationViewModel], RequestError>) -> Void
    ) {
        useCase.getMovieRecommendations(basedOn: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { MovieRecommendationViewModel(from: $0) } })
            }
        }
    }

    func toggleFavorited(
        for movieId: Int,
        _ completionHandler: @escaping () -> Void
    ) {
        useCase.toggleFavorited(for: movieId)
        DispatchQueue.main.async {
            completionHandler()
        }
    }

}
