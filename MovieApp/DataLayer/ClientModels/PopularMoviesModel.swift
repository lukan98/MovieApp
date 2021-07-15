struct PopularMoviesModel: Codable {

    let movies: [MovieClientModel]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

}
