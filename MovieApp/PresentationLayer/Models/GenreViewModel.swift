struct GenreViewModel {

    let id: Int
    let name: String

}

// MARK: Model to ViewModel conversion

extension GenreViewModel {

    init(from model: GenreModel) {
        id = model.id
        name = model.name
    }

}
