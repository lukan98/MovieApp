import Combine
import Foundation
import RealmSwift

class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: MovieNetworkDataSourceProtocol
    private let localDataSource: MovieLocalDataSourceProtocol
    private let localMetadataSource: MovieLocalMetadataSourceProtocol

    var favoriteMovies: AnyPublisher<[DetailedMovieRepositoryModel], Error> {
        localMetadataSource
            .favorites
            .map { [weak self] ids -> AnyPublisher<[DetailedMovieDataSourceModel], Error> in
                guard let self = self else { return Empty(completeImmediately: false).eraseToAnyPublisher() }

                let array = ids.map {
                    self.networkDataSource.details(for: $0)
                }
                return Publishers.MergeMany(array).collect().eraseToAnyPublisher()
            }
            .switchToLatest()
            .map { $0.map { DetailedMovieRepositoryModel(from: $0, isFavorited: true) } }
            .eraseToAnyPublisher()
    }

    private var disposables = Set<AnyCancellable>()

    private var popularMovies: AnyPublisher<[MovieRepositoryModel], Error> {
        Publishers
            .CombineLatest(localDataSource.popularMovies, localMetadataSource.favorites)
            .map { movies, favorites in
                movies.map { MovieRepositoryModel(from: $0, isFavorited: favorites.contains($0.id)) }
            }
            .eraseToAnyPublisher()
    }

    private var topRatedMovies: AnyPublisher<[MovieRepositoryModel], Error> {
        Publishers
            .CombineLatest(localDataSource.topRatedMovies, localMetadataSource.favorites)
            .map { movies, favorites in
                movies.map { MovieRepositoryModel(from: $0, isFavorited: favorites.contains($0.id)) }
            }
            .eraseToAnyPublisher()
    }

    init(
        networkDataSource: MovieNetworkDataSourceProtocol,
        localDataSource: MovieLocalDataSourceProtocol,
        localMetadataSource: MovieLocalMetadataSourceProtocol
    ) {
        self.networkDataSource = networkDataSource
        self.localDataSource = localDataSource
        self.localMetadataSource = localMetadataSource

        bindSources()
    }

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieRepositoryModel], Error> {
        popularMovies
            .map { $0.filter { $0.genres.contains(genreId) } }
            .eraseToAnyPublisher()
    }

    func topRatedMovies(for genreId: Int) -> AnyPublisher<[MovieRepositoryModel], Error> {
        topRatedMovies
            .map { $0.filter { $0.genres.contains(genreId) } }
            .eraseToAnyPublisher()
    }

    func trendingMovies(for timeWindow: TimeWindowRepositoryModel) -> AnyPublisher<[MovieRepositoryModel], Error> {
        Publishers
            .CombineLatest(
                localDataSource.trendingMovies(for: timeWindow.toDataSourceModel()),
                localMetadataSource.favorites)
            .map { movies, favorites in
                movies.map { MovieRepositoryModel(from: $0, isFavorited: favorites.contains($0.id)) }
            }
            .eraseToAnyPublisher()
    }

    func toggleFavorited(for movieId: Int) {
        localMetadataSource.toggleFavorited(for: movieId)
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieRepositoryModel, Error> {
        networkDataSource
            .details(for: movieId)
            .combineLatest(localMetadataSource.favorites)
            .map { movie, favorites in
                DetailedMovieRepositoryModel(from: movie, isFavorited: favorites.contains(movie.id))
            }
            .eraseToAnyPublisher()
    }

    func credits(for movieId: Int) -> AnyPublisher<CreditsRepositoryModel, Error> {
        networkDataSource
            .credits(for: movieId)
            .map { CreditsRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewRepositoryModel], Error> {
        networkDataSource
            .reviews(for: movieId)
            .map { $0.map { ReviewRepositoryModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func recommendations(basedOn movieId: Int) -> AnyPublisher<[MovieRecommendationRepositoryModel], Error> {
        networkDataSource
            .recommendations(basedOn: movieId)
            .map { $0.map { MovieRecommendationRepositoryModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func searchResults(for query: String) -> AnyPublisher<[MovieRepositoryModel], Error> {
        networkDataSource
            .searchResults(for: query)
            .map { $0.map { MovieRepositoryModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    private func bindSources() {
        networkDataSource
            .popularMovies
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in
                    self?.localDataSource.save(movies, with: .popular)
                })
            .store(in: &disposables)

        networkDataSource
            .topRatedMovies
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in
                    self?.localDataSource.save(movies, with: .topRated)
                })
            .store(in: &disposables)

        networkDataSource
            .trendingMovies(for: .day)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in
                    self?.localDataSource.save(movies, with: .trendingDaily)
                })
            .store(in: &disposables)

        networkDataSource
            .trendingMovies(for: .week)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in
                    self?.localDataSource.save(movies, with: .trendingWeekly)
                })
            .store(in: &disposables)
    }

}
