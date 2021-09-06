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

    func searchResults(for query: String) -> AnyPublisher<[MovieViewModel], Error> {
        movieUseCase
            .searchResults(for: query)
            .map { $0.map { MovieViewModel(from: $0) } }
            .receiveOnMain()
    }
}
