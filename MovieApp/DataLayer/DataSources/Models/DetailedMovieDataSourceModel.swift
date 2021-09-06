import Foundation

struct DetailedMovieDataSourceModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [GenreDataSourceModel]
    let voteAverage: Double
    let runtime: Int
    let releaseDate: Date

}

// MARK: ClientModel to DataSourceModel conversion
extension DetailedMovieDataSourceModel {

    init(from model: DetailedMovieClientModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource ?? ""
        genres = model.genres.map { GenreDataSourceModel(from: $0) }
        voteAverage = model.voteAverage
        runtime = model.runtime
        releaseDate = Date(serverDate: model.releaseDate) ?? .distantPast
    }

}
