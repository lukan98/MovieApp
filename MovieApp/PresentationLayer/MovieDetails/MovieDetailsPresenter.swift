class MovieDetailsPresenter {

    private let mockedMovie =
        DetailedMovieViewModel(
            id: 103,
            about: "A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feed his urge for violent action, attempting to save a preadolescent prostitute in the process.",
            name: "Taxi Driver",
            posterSource: "https://image.tmdb.org/t/p/original/ekstpH614fwDX8DUln1a2Opz0N8.jpg",
            genres: [GenreViewModel(id: 80, name: "Crime"), GenreViewModel(id: 18, name: "Drama")],
            isFavorited: false)
    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func getMovieDetails(
        for movieId: Int,
        _ completionHandler: @escaping (Result<DetailedMovieViewModel, RequestError>) -> Void
    ) {
        completionHandler(.success(mockedMovie))
    }

}
