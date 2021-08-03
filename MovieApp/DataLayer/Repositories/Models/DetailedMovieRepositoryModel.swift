struct DetailedMovieRepositoryModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [GenreRepositoryModel]
    let isFavorited: Bool

    public func withFavorited(_ isFavorited: Bool) -> DetailedMovieRepositoryModel {
        DetailedMovieRepositoryModel(
            id: self.id,
            about: self.about,
            name: self.name,
            posterSource: self.posterSource,
            genres: self.genres,
            isFavorited: isFavorited)
    }

}

// MARK: DataSource to Repository Model
extension DetailedMovieRepositoryModel {

    init(from model: DetailedMovieDataSourceModel, isFavorited: Bool = false) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = "https://image.tmdb.org/t/p/w154" + model.posterSource
        genres = model.genres.map { GenreRepositoryModel(from: $0) }
        self.isFavorited = isFavorited
    }

}
