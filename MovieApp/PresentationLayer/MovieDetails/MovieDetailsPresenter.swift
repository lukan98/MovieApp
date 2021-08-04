import Foundation

class MovieDetailsPresenter {

    private let mockedMovie =
        DetailedMovieViewModel(
            id: 103,
            about: "A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feed his urge for violent action, attempting to save a preadolescent prostitute in the process.",
            name: "Taxi Driver",
            posterSource: "https://image.tmdb.org/t/p/original/ekstpH614fwDX8DUln1a2Opz0N8.jpg",
            genres: "Crime, Drama",
            isFavorited: false,
            voteAverage: 8.2,
            runtime: "2h40m",
            releaseYear: "(1976)",
            releaseDate: "02-05-1976")
    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func getMovieDetails(
        _ completionHandler: @escaping (Result<DetailedMovieViewModel, RequestError>) -> Void
    ) {
        completionHandler(.success(mockedMovie))
    }

}
