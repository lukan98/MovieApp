struct GenreDataSourceModel {

    let id: Int
    let name: String

}

// MARK: ClientModel to DataSourceModel conversion
extension GenreDataSourceModel {

    init(from model: GenreClientModel) {
        id = model.id
        name = model.name
    }

}
