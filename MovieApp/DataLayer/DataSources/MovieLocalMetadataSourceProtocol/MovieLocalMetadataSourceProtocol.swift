protocol MovieLocalMetadataSourceProtocol {

    var favorites: [Int] { get }

    func toggleFavorited(for movieId: Int)
    
}
