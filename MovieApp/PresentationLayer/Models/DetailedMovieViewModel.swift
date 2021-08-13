import Foundation

struct DetailedMovieViewModel {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: String
    let isFavorited: Bool
    let voteAverage: Double
    let runtime: String
    let releaseYear: String
    let releaseDate: String

}

// MARK: Model to ViewModel
extension DetailedMovieViewModel {

    init(from model: DetailedMovieModel) {
        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        genres = model.genres.map { GenreViewModel(from: $0).name }.joined(separator: ", ")
        isFavorited = model.isFavorited
        voteAverage = model.voteAverage
        let timeComponents = TimeComponentsViewModel(minutes: model.runtime)
        runtime = timeComponents.uiString
        releaseYear = model.releaseDate.uiYear
        releaseDate = model.releaseDate.uiShortDate
    }

}
