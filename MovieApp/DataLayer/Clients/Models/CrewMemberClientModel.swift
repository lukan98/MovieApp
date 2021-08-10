struct CrewMemberClientModel: Codable {

    let id: Int
    let name: String
    let profileSource: String?
    let job: String
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileSource = "profile_path"
        case job
        case popularity
    }

}
