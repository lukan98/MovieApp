class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {

    private let movieClient: MovieClientProtocol

    init(movieClient: MovieClientProtocol) {
        self.movieClient = movieClient
    }

    func fetchPopularMovies(
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        movieClient.fetchPopularMovies { result in
            completionHandler(result.map { $0.movies.map { MovieDataSourceModel(from: $0) } })
        }
    }

    func fetchPopularMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {
        fetchPopularMovies { result in
            switch result {
            case .success(let movieDataSourceModels):
                let filteredMovieDataSourceModels = movieDataSourceModels.filter { $0.genres.contains(genreId) }
                completionHandler(.success(filteredMovieDataSourceModels))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func fetchTopRatedMovies(
        for genreId: Int,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {

    }

    func fetchTrendingMovies(
        for timeWindowId: Int,
        _ completionHandler: @escaping (Result<[MovieDataSourceModel], RequestError>) -> Void
    ) {

    }

}
