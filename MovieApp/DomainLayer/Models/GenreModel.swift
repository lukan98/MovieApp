struct GenreModel {

    let id: Int
    let name: String

}

// MARK: RepositoryModel to Model conversion

extension GenreModel {

    init(from model: GenreRepositoryModel) {
        id = model.id
        name = model.name
    }

}
