struct MovieDataSourceModel {

    let about: String
    let id: Int
    let name: String
    let posterSource: String

}

// MARK: ClientModel to DataSourceModel conversion

extension MovieDataSourceModel {

    init(from model: MovieClientModel) {
        about = model.about
        id = model.id
        name = model.name
        posterSource = model.posterSource
    }

}
