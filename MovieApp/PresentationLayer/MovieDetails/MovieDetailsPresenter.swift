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
    }

    func credits(for movieId: Int, maxCrewMembers: Int) -> AnyPublisher<CreditsViewModel, Error> {
        useCase
            .credits(for: movieId)
            .map { CreditsViewModel(from: $0).sortAndSliceCrew(first: maxCrewMembers) }
            .receiveOnMain()
    }

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewViewModel], Error> {
        useCase
            .reviews(for: movieId)
            .map { $0.map { ReviewViewModel(from: $0) } }
            .receiveOnMain()
    }

    func recommendations(basedOn movieId: Int) -> AnyPublisher<[MovieRecommendationViewModel], Error> {
        useCase
            .recommendations(basedOn: movieId)
            .map { $0.map { MovieRecommendationViewModel(from: $0) } }
            .receiveOnMain()
    }

    func toggleFavorited(for movieId: Int) {
        useCase.toggleFavorited(for: movieId)
    }

}
