struct MovieRecommendationModel {

    let id: Int
    let title: String
    let backdropPath: String

}

// MARK: RepositoryModel to Model conversion
extension MovieRecommendationModel {

    init(from model: MovieRecommendationRepositoryModel) {
        id = model.id
        title = model.title
        backdropPath = model.backdropPath
    }

}
