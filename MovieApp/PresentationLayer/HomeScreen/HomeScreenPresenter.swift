import Foundation
import UIKit
import Combine

class HomeScreenPresenter {

    var genres: AnyPublisher<[GenreViewModel], Error> {
        genreUseCase
            .genres
            .map { $0.map { GenreViewModel(from: $0) } }
            .receiveOnMain()
            .eraseToAnyPublisher()
    }

    private let movieUseCase: MovieUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol, genreUseCase: GenreUseCaseProtocol) {
        self.movieUseCase = movieUseCase
        self.genreUseCase = genreUseCase
    }

    func getSearchedMovies(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        movieUseCase.getMovieSearchResults(with: query) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { $0.map { MovieViewModel(from: $0) } })
            }
        }
    }

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieViewModel], Error> {
        movieUseCase
            .popularMovies(for: genreId)
            .map { $0.map { MovieViewModel(from: $0) } }
            .receiveOnMain()
    }

    func topRatedMovies(for genreId: Int) -> AnyPublisher<[MovieViewModel], Error> {
        movieUseCase
            .topRatedMovies(for: genreId)
            .map { $0.map { MovieViewModel(from: $0) } }
            .receiveOnMain()
    }

    func trendingMovies(for timeWindow: TimeWindowViewModel) -> AnyPublisher<[MovieViewModel], Error> {
        movieUseCase
            .trendingMovies(for: timeWindow.toModel())
            .map { $0.map { MovieViewModel(from: $0) } }
            .receiveOnMain()
    }

    func toggleFavorited(for movieId: Int) {
        movieUseCase.toggleFavorited(for: movieId)
    }
}
