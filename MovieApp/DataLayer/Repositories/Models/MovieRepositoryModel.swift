struct MovieRepositoryModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]
    let isFavorited: Bool

    public func withFavorited(_ isFavorited: Bool) -> MovieRepositoryModel {
        MovieRepositoryModel(
            id: self.id,
            about: self.about,
            name: self.name,
            posterSource: self.posterSource,
            genres: self.genres,
            isFavorited: isFavorited)
    }

}

// MARK: DataSourceModel to RepositoryModel conversion
extension MovieRepositoryModel {

    init(from model: MovieDataSourceModel, isFavorited: Bool = false) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = "https://image.tmdb.org/t/p/w185" + model.posterSource
        genres = model.genres
        self.isFavorited = isFavorited
    }

    func toDataSourceModel() -> MovieDataSourceModel {
        MovieDataSourceModel(id: id,
                             about: about,
                             name: name,
                             posterSource: posterSource,
                             genres: genres)
    }

}
