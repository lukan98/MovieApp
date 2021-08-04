struct CrewMemberDataSourceModel {

    let id: Int
    let name: String
    let profileSource: String?
    let job: String
    let popularity: Double

}

// MARK: ClientModel to DataSourceModel Conversion
extension CrewMemberDataSourceModel {

    init(from model: CrewMemberClientModel) {
        id = model.id
        name = model.name
        profileSource = model.profileSource
        job = model.job
        popularity = model.popularity
    }

}
