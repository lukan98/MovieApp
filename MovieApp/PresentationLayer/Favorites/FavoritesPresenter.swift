import Foundation
import Combine

class FavoritesPresenter {

    var favoriteMovies: AnyPublisher<[DetailedMovieViewModel], Error> {
        useCase
            .favoriteMovies
            .map { $0.map { DetailedMovieViewModel(from: $0) } }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func toggleFavorited(for movieId: Int) {
        useCase.toggleFavorited(for: movieId)
    }

}
