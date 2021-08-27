import Combine

protocol MovieRepositoryProtocol {

    var favoriteMovies: AnyPublisher<[DetailedMovieRepositoryModel], Error> { get }

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieRepositoryModel], Error>

    func topRatedMovies(for genreId: Int) -> AnyPublisher<[MovieRepositoryModel], Error>

    func trendingMovies(for timeWindow: TimeWindowRepositoryModel) -> AnyPublisher<[MovieRepositoryModel], Error>

    func toggleFavorited(for movieId: Int)

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieRepositoryModel, Error>

    func credits(for movieId: Int) -> AnyPublisher<CreditsRepositoryModel, Error>

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewRepositoryModel], Error>

    func recommendations(basedOn movieId: Int) -> AnyPublisher<[MovieRecommendationRepositoryModel], Error>
    
    func getMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationRepositoryModel], RequestError>) -> Void
    )

    func getMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieRepositoryModel], RequestError>) -> Void
    )

}
