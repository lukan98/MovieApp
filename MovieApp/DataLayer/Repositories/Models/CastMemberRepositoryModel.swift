struct CastMemberRepositoryModel {

    let id: Int
    let name: String
    let profileSource: String?
    let characterName: String

}

// MARK: DataSourceModel to RepositoryModel Conversion
extension CastMemberRepositoryModel {

    init(from model: CastMemberDataSourceModel) {
        id = model.id
        name = model.name
        if let profilePath = model.profileSource {
            profileSource = "https://image.tmdb.org/t/p/w185" + profilePath
        } else {
            profileSource = nil
        }
        characterName = model.characterName
    }

}
