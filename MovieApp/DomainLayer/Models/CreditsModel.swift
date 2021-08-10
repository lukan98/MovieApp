struct CreditsModel {

    let cast: [CastMemberModel]
    let crew: [CrewMemberModel]

}

// MARK: ClientModel to DataSourceModel Conversion
extension CreditsModel {

    init(from model: CreditsRepositoryModel) {
        cast = model.cast.map { CastMemberModel(from: $0) }
        crew = model.crew.map { CrewMemberModel(from: $0) }
    }

}
