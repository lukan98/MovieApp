protocol MovieUserDefaultsDataSourceProtocol {

    func toggleFavorited(for movieId: Int)

    func getFavorites() -> [Int]

}
