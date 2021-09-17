import Combine

protocol MovieLocalDataSourceProtocol {

    var popularMovies: AnyPublisher<[MovieDataSourceModel], Error> { get }

    var topRatedMovies: AnyPublisher<[MovieDataSourceModel], Error> { get }

    func trendingMovies(for timeWindow: TimeWindowDataSourceModel) -> AnyPublisher<[MovieDataSourceModel], Error>

    func save(_ movies: [MovieDataSourceModel], with category: CategoryDataSourceModel)

}
