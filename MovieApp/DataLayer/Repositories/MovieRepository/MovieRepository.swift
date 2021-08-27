import Combine
import Foundation

class MovieRepository: MovieRepositoryProtocol {

    private let networkDataSource: MovieNetworkDataSourceProtocol
    private let localMetadataSource: MovieLocalMetadataSourceProtocol

    var favoriteMoviesPublisher: AnyPublisher<[DetailedMovieRepositoryModel], Error> {
        localMetadataSource
            .favorites
            .map { [weak self] ids -> AnyPublisher<[DetailedMovieDataSourceModel], Error> in
                guard let self = self else { return Empty(completeImmediately: false).eraseToAnyPublisher() }

                let array = ids.map {
                    self.networkDataSource.fetchMovieDetails(for: $0)
                }
                return Publishers.MergeMany(array).collect().eraseToAnyPublisher()
            }
            .switchToLatest()
            .map { $0.map { DetailedMovieRepositoryModel(from: $0, isFavorited: true) } }
            .eraseToAnyPublisher()
    }

    private var popularMovies: AnyPublisher<[MovieRepositoryModel], Error> {
        Publishers
            .CombineLatest(networkDataSource.popularMovies, localMetadataSource.favorites)
            .map { movies, favorites in
                movies.map { MovieRepositoryModel(from: $0, isFavorited: favorites.contains($0.id)) }
            }
            .eraseToAnyPublisher()
    }

    private var topRatedMovies: AnyPublisher<[MovieRepositoryModel], Error> {
        networkDataSource
            .topRatedMovies
            .combineLatest(localMetadataSource.favorites)
            .map { movies, favorites in
                movies.map { MovieRepositoryModel(from: $0, isFavorited: favorites.contains($0.id)) }
            }
            .eraseToAnyPublisher()
    }

    init(
        networkDataSource: MovieNetworkDataSourceProtocol,
        localMetadataSource: MovieLocalMetadataSourceProtocol
    ) {
        self.networkDataSource = networkDataSource
        self.localMetadataSource = localMetadataSource
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
        networkDataSource
            .trendingMovies(for: timeWindow.toDataSourceModel())
            .combineLatest(localMetadataSource.favorites)
            .map { movies, favorites in
                movies.map { MovieRepositoryModel(from: $0, isFavorited: favorites.contains($0.id)) }
            }
            .eraseToAnyPublisher()
    }

    func toggleFavorited(for movieId: Int) {
        localMetadataSource.toggleFavorited(for: movieId)
    }

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieRepositoryModel, RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieDetails(for: movieId) { result in
            completionHandler(result.map { DetailedMovieRepositoryModel(from: $0) })
        }
    }

    func getMovieCredits(
        for movieId: Int,
        _ completionHandler: @escaping (Result<CreditsRepositoryModel, RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieCredits(for: movieId) { result in
            completionHandler(result.map { CreditsRepositoryModel(from: $0) })
        }
    }

    func getMovieReviews(
        for movieId: Int,
        _ completionHandler: @escaping (Result<[ReviewRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieReviews(for: movieId) { result in
            completionHandler(result.map { $0.map { ReviewRepositoryModel(from: $0) } })
        }
    }

    func getMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieRecommendations(basedOn: movieId) { result in
            completionHandler(result.map { $0.map { MovieRecommendationRepositoryModel(from: $0) } })
        }
    }

    func getMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchMovieSearchResults(with: query) { result in
            completionHandler(result.map { $0.map { MovieRepositoryModel(from: $0) } })
        }
    }

}
