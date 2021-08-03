struct DetailedMovieDataSourceModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [GenreDataSourceModel]

}

// MARK: ClientModel to DataSourceModel conversion
extension DetailedMovieDataSourceModel {

    init(from model: DetailedMovieClientModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres.map { GenreDataSourceModel(from: $0) }
    }

}
