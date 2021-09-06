import Combine

protocol MovieLocalMetadataSourceProtocol {

    var favorites: AnyPublisher<[Int], Error> { get }

    func toggleFavorited(for movieId: Int)

}
