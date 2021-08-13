struct ReviewClientModel: Codable {

    let authorDetails: AuthorDetailsClientModel
    let content: String
    let creationDate: String

    enum CodingKeys: String, CodingKey {
        case authorDetails = "author_details"
        case content
        case creationDate = "created_at"
    }

}
