struct MovieModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String

}

// MARK: RepositoryModel to Model conversion

extension MovieModel {

    init(from model: MovieRepositoryModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
    }

}
