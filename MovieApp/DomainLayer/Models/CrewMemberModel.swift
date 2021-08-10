struct CrewMemberModel {

    let id: Int
    let name: String
    let profileSource: String?
    let job: String
    let popularity: Double

}

// MARK: RepositoryModel to Model Conversion
extension CrewMemberModel {

    init(from model: CrewMemberRepositoryModel) {
        id = model.id
        name = model.name
        profileSource = model.profileSource
        job = model.job
        popularity = model.popularity
    }

}
