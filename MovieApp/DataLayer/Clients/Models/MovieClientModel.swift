struct MovieClientModel: Codable {

    let id: Int
    let about: String
    let name: String
    let posterSource: String
    let genres: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case about = "overview"
        case name = "title"
        case posterSource = "poster_path"
        case genres = "genre_ids"
    }

}
