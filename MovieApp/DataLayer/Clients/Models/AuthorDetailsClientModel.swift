struct AuthorDetailsClientModel: Codable {

    let name: String
    let username: String
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
    }

}
