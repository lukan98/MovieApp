class NetworkDataSource: NetworkDataSourceProtocol {

    private let movieClient: MovieClientProtocol

    init(movieClient: MovieClientProtocol) {
        self.movieClient = movieClient
    }
    
    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchPopularMovies { result in
            switch result {
            case .success(let movieList):
                let movies = movieList.movies.map { MovieDataSourceModel(from: $0) }
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
