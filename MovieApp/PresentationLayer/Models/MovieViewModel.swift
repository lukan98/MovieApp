struct MovieViewModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]
    let isFavorited: Bool
    
}

extension MovieViewModel {

    init(from model: MovieViewModel, isFavorited: Bool) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres
        self.isFavorited = isFavorited
    }

}

// MARK: Model to ViewModel conversion
extension MovieViewModel {

    init(from model: MovieModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = "https://image.tmdb.org/t/p/w154"+model.posterSource
        genres = model.genres
        isFavorited = model.isFavorited
    }

}
