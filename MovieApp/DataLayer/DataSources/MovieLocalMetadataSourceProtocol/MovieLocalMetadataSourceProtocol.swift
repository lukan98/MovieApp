import Combine

protocol MovieLocalMetadataSourceProtocol {

    var favorites: [Int] { get }
    var favoritesPublisher: AnyPublisher<[Int], Never> { get }

    func toggleFavorited(for movieId: Int)
    
}
