struct MovieRepositoryModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]
    let isFavorited: Bool

}

extension MovieRepositoryModel {

    init(from model: MovieRepositoryModel, isFavorited: Bool) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres
        self.isFavorited = isFavorited
    }

}

// MARK: DataSourceModel to RepositoryModel conversion
extension MovieRepositoryModel {

    init(from model: MovieDataSourceModel, isFavorited: Bool = false) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres
        self.isFavorited = isFavorited
    }

}
