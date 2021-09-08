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

// MARK: Hashable
extension MovieViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        lhs.id == rhs.id && lhs.isFavorited == rhs.isFavorited
    }

}
