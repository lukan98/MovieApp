import RealmSwift
import Combine
import Foundation

class MovieLocalDataSource: MovieLocalDataSourceProtocol {

    var popularMovies: AnyPublisher<[MovieDataSourceModel], Error> {
        guard let realm = try? Realm() else {
            print("Couldn't create realm")
            return .never()
        }

        return realm
            .objects(MovieLocalDataSourceModel.self)
            .filter(NSPredicate(format: "type == %d", CategoryDataSourceModel.popular.rawValue))
            .collectionPublisher
            .map { $0.map { $0.toDataSourceModel() } }
            .eraseToAnyPublisher()
    }

    var topRatedMovies: AnyPublisher<[MovieDataSourceModel], Error> {
        guard let realm = try? Realm() else {
            print("Couldn't create realm")
            return .never()
        }

        return realm
            .objects(MovieLocalDataSourceModel.self)
            .filter(NSPredicate(format: "type == %d", CategoryDataSourceModel.topRated.rawValue))
            .collectionPublisher
            .map { $0.map { $0.toDataSourceModel() } }
            .eraseToAnyPublisher()
    }

    private var disposables = Set<AnyCancellable>()

    func trendingMovies(for timeWindow: TimeWindowDataSourceModel) -> AnyPublisher<[MovieDataSourceModel], Error> {
        guard let realm = try? Realm() else {
            print("Couldn't create realm")
            return .never()
        }

        return realm
            .objects(MovieLocalDataSourceModel.self)
            .filter(NSPredicate(format: "type == %d", CategoryDataSourceModel(from: timeWindow).rawValue))
            .collectionPublisher
            .map { $0.map { $0.toDataSourceModel() } }
            .eraseToAnyPublisher()
    }

    func details(for movieId: Int) -> AnyPublisher<DetailedMovieDataSourceModel, Error> {
        guard let realm = try? Realm() else {
            print("Couldn't create realm")
            return .never()
        }

        return realm
            .objects(DetailedMovieLocalDataSourceModel.self)
            .filter { $0.id == movieId }.first
            .publisher
            .map { $0.toDataSourceModel() }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func save(_ movies: [MovieDataSourceModel], with category: CategoryDataSourceModel) {
        guard let realm = try? Realm() else {
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
