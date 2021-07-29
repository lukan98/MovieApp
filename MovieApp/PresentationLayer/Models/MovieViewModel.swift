struct MovieViewModel {

    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]
    
}

// MARK: Model to ViewModel conversion
extension MovieViewModel {

    init(from model: MovieModel) {
        about = model.about
        name = model.name
        posterSource = "https://image.tmdb.org/t/p/w154"+model.posterSource
        genres = model.genres
    }

}
