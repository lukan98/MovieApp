import Foundation
import Combine

class MovieDetailsPresenter {

    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieViewModel, Error> {
        useCase
            .details(for: movieId)
            .map { DetailedMovieViewModel(from: $0) }
            .receiveOnMain()
            .eraseToAnyPublisher()
    }

    func credits(for movieId: Int, maxCrewMembers: Int) -> AnyPublisher<CreditsViewModel, Error> {
        useCase
            .credits(for: movieId)
            .map { CreditsViewModel(from: $0).sortAndSliceCrew(first: maxCrewMembers) }
            .receiveOnMain()
            .eraseToAnyPublisher()
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
