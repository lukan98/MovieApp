struct CrewMemberRepositoryModel {

    let id: Int
    let name: String
    let profileSource: String?
    let job: String
    let popularity: Double

}

// MARK: DataSource to RepositoryModel Conversion
extension CrewMemberRepositoryModel {

    init(from model: CrewMemberDataSourceModel) {
        id = model.id
        name = model.name
        if let profilePath = model.profileSource {
            profileSource = "https://image.tmdb.org/t/p/w185" + profilePath
        } else {
            profileSource = model.profileSource
        }
        job = model.job
        popularity = model.popularity
    }

}
