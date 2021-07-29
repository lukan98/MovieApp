import Foundation

class MovieUserDefaultsDataSource: MovieUserDefaultsDataSourceProtocol {

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favorites"

    func toggleFavorited(for movieId: Int) {
        guard var favorites = userDefaults.object(forKey: favoritesKey) as? [Int]
        else {
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

    func getFavorites() -> [Int] {
        if let favorites = userDefaults.object(forKey: favoritesKey) as? [Int] {
            return favorites
        } else {
            return []
        }
    }

}
