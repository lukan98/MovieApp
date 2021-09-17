import RealmSwift
import Combine

class MovieLocalDataSource: MovieLocalDataSourceProtocol {

    var popularMovies: AnyPublisher<[MovieDataSourceModel], Error> {
        movies
            .map { $0.filter { $0.categories.contains(.popular) } }
            .map { $0.map { $0.toDataSourceModel() } }
            .eraseToAnyPublisher()
    }

    var topRatedMovies: AnyPublisher<[MovieDataSourceModel], Error> {
        movies
            .map { $0.filter { $0.categories.contains(.topRated) } }
            .map { $0.map { $0.toDataSourceModel() } }
            .eraseToAnyPublisher()
    }

    private var disposables = Set<AnyCancellable>()

    private var movies: AnyPublisher<[MovieLocalDataSourceModel], Error> {
        guard let realm = try? Realm()
        else {
            print("Couldn't create realm")
            return .never()
        }

        return realm
            .objects(MovieLocalDataSourceModel.self)
            .collectionPublisher
            .map { $0.map { $0 } }
            .eraseToAnyPublisher()
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieDataSourceModel, Error> {
        guard let realm = try? Realm()
        else {
            print("Couldn't create realm")
            return .never()
        }

        return realm
            .objects(DetailedMovieLocalDataSourceModel.self)
            .filter { $0.id == movieId }
            .publisher
            .map { $0.toDataSourceModel() }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func trendingMovies(for timeWindow: TimeWindowDataSourceModel) -> AnyPublisher<[MovieDataSourceModel], Error> {
        movies
            .map { $0.filter { $0.categories.contains(CategoryDataSourceModel(from: timeWindow)) } }
            .map { $0.map { $0.toDataSourceModel() } }
            .eraseToAnyPublisher()
    }

    func save(_ movies: [MovieDataSourceModel], with category: CategoryDataSourceModel) {
        guard let realm = try? Realm()
        else {
            print("Couldn't create realm")
            return
        }

        do {
            try realm.write {
                movies.forEach { movie in
                    if let localMovieModel = realm.object(
                        ofType: MovieLocalDataSourceModel.self,
                        forPrimaryKey: movie.id) {
                        localMovieModel.categories.insert(category)
                        realm.add(localMovieModel, update: .modified)
                    } else {
                        realm.add(
                            MovieLocalDataSourceModel(from: movie, category: category),
                            update: .modified)
                    }
                }
            }
        } catch {
            print("An error ocurred while writing to the realm")
        }
    }

    func save(_ movie: DetailedMovieDataSourceModel) {
        guard let realm = try? Realm()
        else {
            print("Couldn't create realm")
            return
        }

        do {
            try realm.write {
                realm.add(
                    DetailedMovieLocalDataSourceModel(from: movie),
                    update: .modified)
            }
        } catch {
            print("An error ocurred while writing to the realm")
        }
    }

}
