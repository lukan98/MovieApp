class HomeScreenPresenter {

    private let movies = MockDataService.movies

    public var numberOfMovies: Int {
        movies.count
    }

    func getMovie(at index: Int) -> Movie? {
        movies[index]
    }

}
