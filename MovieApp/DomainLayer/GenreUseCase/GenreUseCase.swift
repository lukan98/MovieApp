class GenreUseCase: GenreUseCaseProtocol {

    private let genreRepository: GenreRepositoryProtocol

    init(genreRepository: GenreRepositoryProtocol) {
        self.genreRepository = genreRepository
    }
    
    func getGenres(_ completionHandler: @escaping (Result<[GenreModel], RequestError>) -> Void) {
        genreRepository.getGenres { result in
            completionHandler(result.map { $0.map { GenreModel(from: $0) } })
        }
    }

}
