struct MovieRepositoryModel {

    let about: String
    let id: Int
    let name: String
    let posterSource: String

}

// MARK: DataSourceModel to RepositoryModel conversion

extension MovieRepositoryModel {

    init(from model: MovieDataSourceModel) {
        about = model.about
        id = model.id
        name = model.name
        posterSource = model.posterSource
    }

}
