struct OptionViewModel {

    let id: Int
    let name: String

}

// MARK: GenreViewModel to OptionViewModel conversion
extension OptionViewModel {

    init(from model: GenreViewModel) {
        self.id = model.id
        self.name = model.name
    }

}
