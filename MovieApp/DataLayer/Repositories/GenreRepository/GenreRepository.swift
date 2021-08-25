import Combine

class GenreRepository: GenreRepositoryProtocol {

    var genres: AnyPublisher<[GenreRepositoryModel], Error> {
        networkDataSource
            .genres
            .map( { $0.map { GenreRepositoryModel(from: $0) } })
            .eraseToAnyPublisher()
    }

    private let networkDataSource: GenreNetworkDataSourceProtocol

    private var storedGenres: [GenreRepositoryModel]

    init(networkDataSource: GenreNetworkDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        storedGenres = []
    }

    func getGenres(
        _ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void
    ) {
        getGenresFromLocal { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let genreRepositoryModels):
                completionHandler(.success(genreRepositoryModels))
            case .failure:
                self.getGenresFromNetwork { result in
                    switch result {
                    case .success(let genreRepositoryModels):
                        completionHandler(.success(genreRepositoryModels))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            }
        }
    }

    private func getGenresFromLocal(
        _ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void
    ) {
        if storedGenres.isEmpty {
            completionHandler(.failure(.noDataError))
        } else {
            completionHandler(.success(storedGenres))
        }
    }

    private func getGenresFromNetwork(
        _ completionHandler: @escaping (Result<[GenreRepositoryModel], RequestError>) -> Void
    ) {
        networkDataSource.fetchGenres { [weak self] result in
            guard let self = self else { return }

            let mappedResult = result.map { $0.map { GenreRepositoryModel(from: $0) } }
            switch mappedResult {
            case .success(let genreRepositoryModels):
                self.storedGenres = genreRepositoryModels
                self.getGenresFromLocal(completionHandler)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
