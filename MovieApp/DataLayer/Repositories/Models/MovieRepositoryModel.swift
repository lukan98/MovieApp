struct MovieRepositoryModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]

}

// MARK: DataSourceModel to RepositoryModel conversion
extension MovieRepositoryModel {

    init(from model: MovieDataSourceModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = []
    }

}
