struct MovieRecommendationClientModel: Codable {

    let title: String
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case title
        case backdropPath = "backdrop_path"
    }

}
