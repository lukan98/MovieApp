import Combine

protocol MovieLocalMetadataSourceProtocol {

    var favorites: [Int] { get }
    var favoritesPublisher: AnyPublisher<[Int], Error> { get }

    func toggleFavorited(for movieId: Int)
    
}
