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
    
    func getMovieRecommendations(
        basedOn movieId: Int,
        _ completionHandler: @escaping (Result<[MovieRecommendationModel], RequestError>) -> Void
    )

    func getMovieSearchResults(
        with query: String,
        _ completionHandler: @escaping (Result<[MovieModel], RequestError>) -> Void
    )

}
