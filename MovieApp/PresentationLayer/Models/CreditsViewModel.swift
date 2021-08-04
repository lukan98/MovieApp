struct CreditsViewModel {

    let cast: [CastMemberViewModel]
    let crew: [CrewMemberViewModel]

}

// MARK: ClientModel to DataSourceModel Conversion
extension CreditsViewModel {

    init(from model: CreditsModel) {
        cast = model.cast.map { CastMemberViewModel(from: $0) }
        crew = model.crew
            .map { CrewMemberViewModel(from: $0) }
            .sorted { $0.popularity > $1.popularity }
            .dropLast(model.crew.count - 6)
    }

}
