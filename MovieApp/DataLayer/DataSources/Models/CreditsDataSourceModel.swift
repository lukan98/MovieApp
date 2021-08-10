struct CreditsDataSourceModel {

    let cast: [CastMemberDataSourceModel]
    let crew: [CrewMemberDataSourceModel]

}

// MARK: ClientModel to DataSourceModel Conversion
extension CreditsDataSourceModel {

    init(from model: CreditsClientModel) {
        cast = model.cast.map { CastMemberDataSourceModel(from: $0) }
        crew = model.crew.map { CrewMemberDataSourceModel(from: $0) }
    }

}
