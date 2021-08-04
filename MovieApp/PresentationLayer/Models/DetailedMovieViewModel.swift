import Foundation

struct DetailedMovieViewModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [GenreViewModel]
    let isFavorited: Bool
    let voteAverage: Double
    let runtime: Int
    let releaseDate: Date

}

// MARK: Model to ViewModel
extension DetailedMovieViewModel {

    init(from model: DetailedMovieModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres.map { GenreViewModel(from: $0) }
        isFavorited = model.isFavorited
        voteAverage = model.voteAverage
        runtime = model.runtime
        releaseDate = model.releaseDate
    }

}
