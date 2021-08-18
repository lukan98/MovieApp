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

    func getSearchedMovies(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        DispatchQueue.main.async {
            completionHandler(.success(Array(
                                        repeating: MovieViewModel(
                                            id: 1,
                                            about: "aaaaa",
                                            name: "aaaaa",
                                            posterSource: "https://image.tmdb.org/t/p/w185/rYFAvSPlQUCebayLcxyK79yvtvV.jpg",
                                            genres: [1, 2],
                                            isFavorited: true),
                                        count: 10)))
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

    func toggleFavorited(for movieId: Int, _ completionHandler: () -> Void) {
        movieUseCase.toggleFavorited(for: movieId)
        completionHandler()
    }
}
