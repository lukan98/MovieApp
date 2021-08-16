struct MovieRecommendationViewModel {

    let title: String
    let backdropPath: String

}

// MARK: Model to ViewModel conversion
extension MovieRecommendationViewModel {

    init(from model: MovieRecommendationModel) {
        title = model.title
        backdropPath = model.backdropPath
    }

}
