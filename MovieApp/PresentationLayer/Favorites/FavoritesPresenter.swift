import Foundation

class FavoritesPresenter {

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

}
