struct MovieViewModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]
    let isFavorited: Bool
    
}

// MARK: Model to ViewModel conversion
extension MovieViewModel {

    init(from model: MovieModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres
        isFavorited = model.isFavorited
    }

}

// MARK: From DetailedViewModel
extension MovieViewModel {

    init(from model: DetailedMovieViewModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres.map { $0.id }
        isFavorited = model.isFavorited
    }

}
