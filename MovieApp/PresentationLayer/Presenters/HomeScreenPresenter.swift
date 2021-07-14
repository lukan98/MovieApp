class HomeScreenPresenter {

    private let movies = MockDataService.movies

    func getNumberOfMovies() -> Int {
        movies.count
    }

    func getMovieAt(index: Int) -> Movie? {
        movies[index]
    }

}
