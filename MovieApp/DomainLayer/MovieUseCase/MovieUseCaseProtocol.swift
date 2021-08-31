import Combine

protocol MovieUseCaseProtocol {

    var favoriteMovies: AnyPublisher<[DetailedMovieModel], Error> { get }

    func popularMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error>

    func topRatedMovies(for genreId: Int) -> AnyPublisher<[MovieModel], Error>

    func trendingMovies(for timeWindow: TimeWindowModel) -> AnyPublisher<[MovieModel], Error>

    func toggleFavorited(for movieId: Int)

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieModel, Error>

    func credits(for movieId: Int) -> AnyPublisher<CreditsModel, Error>

    func reviews(for movieId: Int) -> AnyPublisher<[ReviewModel], Error>

    func recommendations(basedOn movieId: Int) -> AnyPublisher<[MovieRecommendationModel], Error>

    func searchResults(for query: String) -> AnyPublisher<[MovieModel], Error>

}
