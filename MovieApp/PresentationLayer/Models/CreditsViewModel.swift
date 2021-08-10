struct CreditsViewModel {

    let cast: [CastMemberViewModel]
    let crew: [CrewMemberViewModel]

    func sortAndSliceCrew() -> CreditsViewModel {
        let sortedAndSlicedCrew = crew
            .sorted { $0.popularity > $1.popularity }
            .prefix(6)
        let credits = CreditsViewModel(cast: cast, crew: Array(sortedAndSlicedCrew))
        return credits
    }

}

// MARK: ClientModel to DataSourceModel Conversion
extension CreditsViewModel {

    init(from model: CreditsModel) {
        cast = model.cast.map { CastMemberViewModel(from: $0) }
        crew = model.crew.map { CrewMemberViewModel(from: $0) }
    }

}
