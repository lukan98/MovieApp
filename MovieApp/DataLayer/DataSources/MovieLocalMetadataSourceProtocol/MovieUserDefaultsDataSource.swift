import Foundation

class MovieUserDefaultsDataSource: MovieLocalMetadataSourceProtocol {

    var favorites: [Int] {
        if let favorites = userDefaults.object(forKey: favoritesKey) as? [Int] {
            return favorites
        }
        return []
    }

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "movie.favorites"

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