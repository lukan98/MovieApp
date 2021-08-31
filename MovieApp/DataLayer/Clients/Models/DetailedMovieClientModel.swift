import Foundation

struct DetailedMovieClientModel: Codable {

    let id: Int
    let about: String
    let name: String
    let posterSource: String?
    let genres: [GenreClientModel]
    let voteAverage: Double
    let runtime: Int
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case about = "overview"
        case name = "title"
        case posterSource = "poster_path"
        case genres
        case voteAverage = "vote_average"
        case runtime
        case releaseDate = "release_date"
    }

}
