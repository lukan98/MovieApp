struct Movie {

    let about: String
    let id: Int
    let name: String
    let posterSource: String

}

// MARK: RepositoryModel to Model conversion

extension Movie {

    init(from model: MovieRepositoryModel) {
        about = model.about
        id = model.id
        name = model.name
        posterSource = model.posterSource
    }

}
