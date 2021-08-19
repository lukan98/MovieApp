import Foundation
import Combine

class MovieUserDefaultsDataSource: MovieLocalMetadataSourceProtocol {

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "movieFavorites"

    var favorites: [Int] {
        if let favorites = userDefaults.object(forKey: favoritesKey) as? [Int] {
            return favorites
        }
        return []
    }


    var favoritesPublisher: AnyPublisher<[Int], Never> {
        userDefaults
            .publisher(for: \.movieFavorites)
            .map { ($0 as? [Int]) ?? [] }
            .eraseToAnyPublisher()
    }

    func toggleFavorited(for movieId: Int) {
        guard var favorites = userDefaults.object(forKey: favoritesKey) as? [Int] else {
            userDefaults.setValue([movieId], forKey: favoritesKey)
            return
        }

        if favorites.contains(movieId) {
            favorites.removeAll { $0 == movieId }
        } else {
            favorites.append(movieId)
        }
        userDefaults.setValue(favorites, forKey: favoritesKey)
    }

}
