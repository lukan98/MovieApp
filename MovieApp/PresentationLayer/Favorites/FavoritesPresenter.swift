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

    func getFavoriteMovies(
        _ completionHandler: @escaping (Result<[DetailedMovieViewModel], RequestError>) -> Void
    ) {
        useCase
            .getFavoriteMovies { result in
                DispatchQueue.main.async {
                    completionHandler(result.map { $0.map { DetailedMovieViewModel(from: $0) } })
                }
            }
    }

    func toggleFavorited(for movieId: Int, _ completionHandler: () -> Void) {
        useCase.toggleFavorited(for: movieId)
        completionHandler()
    }

}
