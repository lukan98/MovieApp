import Foundation

class MovieDetailsPresenter {

    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func getMovieDetails(
        _ completionHandler: @escaping (Result<DetailedMovieViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieDetails(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { DetailedMovieViewModel(from: $0) } )
            }
        }
    }

    func getMovieCredits(
        maximumCrewMembers max: Int,
        _ completionHandler: @escaping (Result<CreditsViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieCredits(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { CreditsViewModel(from: $0).sortAndSliceCrew(first: max) } )
            }
        }
    }

    func getReview(
        _ completionHandler: @escaping (Result<[ReviewViewModel], RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieReviews(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { ReviewViewModel(from: $0)}})
            }
        }
    }

}
