struct MovieDataSourceModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String

}

// MARK: ClientModel to DataSourceModel conversion

extension MovieDataSourceModel {

    init(from model: MovieClientModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
    }

}
