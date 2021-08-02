class FavoritesPresenter {

    func getFavoriteMovies(
        _ completionHandler: @escaping (Result<[MovieViewModel], RequestError>) -> Void
    ) {
        let mockMovie = MovieViewModel(
            id: 103,
            about: "A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feed his urge for violent action, attempting to save a preadolescent prostitute in the process.",
            name: "Taxi Driver",
            posterSource: "https://image.tmdb.org/t/p/w300/ekstpH614fwDX8DUln1a2Opz0N8.jpg",
            genres: [18, 80],
            isFavorited: false)
        let mockMovies = Array(repeating: mockMovie, count: 100)
        completionHandler(.success(mockMovies))
    }

}
