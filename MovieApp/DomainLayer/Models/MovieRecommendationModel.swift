struct MovieRecommendationModel {

    let title: String
    let backdropPath: String

}

// MARK: RepositoryModel to Model conversion
extension MovieRecommendationModel {

    init(from model: MovieRecommendationRepositoryModel) {
        title = model.title
        backdropPath = model.backdropPath
    }

}
