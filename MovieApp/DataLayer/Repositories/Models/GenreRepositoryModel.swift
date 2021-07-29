struct GenreRepositoryModel {

    let id: Int
    let name: String

}

// MARK: DataSourceModel to RepositoryModel Conversion
extension GenreRepositoryModel {

    init(from model: GenreDataSourceModel) {
        id = model.id
        name = model.name
    }

}
