import Foundation
import UIKit

class HomeScreenPresenter {

    private let movieUseCase: MovieUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol, genreUseCase: GenreUseCaseProtocol) {
        self.movieUseCase = movieUseCase
        self.genreUseCase = genreUseCase
    }

    func getGenres(_ completionHandler: @escaping (Result<[GenreViewModel], RequestError>) -> Void) {
        genreUseCase.getGenres { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { GenreViewModel(from: $0) } })
            }
        }
    }

    func getPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        movieUseCase.getPopularMovies(for: genreId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { MovieViewModel(from: $0) } })
            }
        }
    }

    func getTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        movieUseCase.getTopRatedMovies(for: genreId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { MovieViewModel(from: $0) } })
            }
        }
    }

    func getTrendingMovies(
        for timeWindow: TimeWindowViewModel,
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        movieUseCase.getTrendingMovies(for: timeWindow.toModel()) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { MovieViewModel(from: $0) } })
            }
        }
    }
}
