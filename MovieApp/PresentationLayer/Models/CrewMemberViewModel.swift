struct CrewMemberViewModel {

    let id: Int
    let name: String
    let profileSource: String?
    let job: String
    let popularity: Double

}

// MARK: Model to ViewModel Conversion
extension CrewMemberViewModel {

    init(from model: CrewMemberModel) {
        id = model.id
        name = model.name
        profileSource = model.profileSource
        job = model.job
        popularity = model.popularity
    }

}
