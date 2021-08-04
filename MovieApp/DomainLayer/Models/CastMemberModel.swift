struct CastMemberModel {

    let id: Int
    let name: String
    let profileSource: String?
    let characterName: String

}

// MARK: RepositoryModel to Model Conversion
extension CastMemberModel {

    init(from model: CastMemberRepositoryModel) {
        id = model.id
        name = model.name
        profileSource = model.profileSource
        characterName = model.characterName
    }

}
