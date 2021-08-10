struct CreditsRepositoryModel {

    let cast: [CastMemberRepositoryModel]
    let crew: [CrewMemberRepositoryModel]

}

// MARK: DataSourceModel to Repository Conversion
extension CreditsRepositoryModel {

    init(from model: CreditsDataSourceModel) {
        cast = model.cast.map { CastMemberRepositoryModel(from: $0) }
        crew = model.crew.map { CrewMemberRepositoryModel(from: $0) }
    }

}
