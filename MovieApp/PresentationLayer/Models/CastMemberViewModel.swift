struct CastMemberViewModel {

    let id: Int
    let name: String
    let profileSource: String?
    let characterName: String

}

// MARK: Model to ViewModel Conversion
extension CastMemberViewModel {

    init(from model: CastMemberModel) {
        id = model.id
        name = model.name
        profileSource = model.profileSource
        characterName = model.characterName
    }

}
