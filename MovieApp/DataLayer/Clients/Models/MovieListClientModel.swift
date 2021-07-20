struct MovieListClientModel: Codable {

    let movies: [MovieClientModel]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

}
