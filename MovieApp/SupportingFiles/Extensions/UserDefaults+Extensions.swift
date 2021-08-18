import Foundation

extension UserDefaults {

    @objc
    dynamic var movieFavorites: [Any]? {
        array(forKey: "movieFavorites")
    }

}
