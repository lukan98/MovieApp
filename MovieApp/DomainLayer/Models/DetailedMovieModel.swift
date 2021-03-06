import Foundation

struct DetailedMovieModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [GenreModel]
    let isFavorited: Bool
    let voteAverage: Double
    let runtime: Int
    let releaseDate: Date

}

// MARK: RepositoryModel to Model
extension DetailedMovieModel {

    init(from model: DetailedMovieRepositoryModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres.map { GenreModel(from: $0) }
        isFavorited = model.isFavorited
        voteAverage = model.voteAverage
        runtime = model.runtime
        releaseDate = model.releaseDate
    }

}
