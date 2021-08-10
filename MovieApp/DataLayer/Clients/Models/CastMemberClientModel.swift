struct CastMemberClientModel: Codable {

    let id: Int
    let name: String
    let profileSource: String?
    let characterName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileSource = "profile_path"
        case characterName = "character"
    }

}
