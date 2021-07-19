struct MovieViewModel {

    let about: String
    let name: String
    let posterSource: String
    
}

// MARK: Model to ViewModel conversion

extension MovieViewModel {

    init(from model: Movie) {
        about = model.about
        name = model.name
        posterSource = "https://image.tmdb.org/t/p/w185" + model.posterSource
    }

}
