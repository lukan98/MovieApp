import Combine

class GenreUseCase: GenreUseCaseProtocol {

    var genres: AnyPublisher<[GenreModel], Error> {
        genreRepository
            .genres
            .map { $0.map { GenreModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    private let genreRepository: GenreRepositoryProtocol

    init(genreRepository: GenreRepositoryProtocol) {
        self.genreRepository = genreRepository
    }

}
