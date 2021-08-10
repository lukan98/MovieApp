struct CastMemberDataSourceModel {

    let id: Int
    let name: String
    let profileSource: String?
    let characterName: String

}

// MARK: ClientModel to DataSourceModel Conversion
extension CastMemberDataSourceModel {

    init(from model: CastMemberClientModel) {
        id = model.id
        name = model.name
        profileSource = model.profileSource
        characterName = model.characterName
    }

}
