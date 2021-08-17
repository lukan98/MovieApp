struct MovieRecommendationClientModel: Codable {

    let id: Int
    let title: String
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
    }

}
