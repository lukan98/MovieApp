struct MovieRecommendationViewModel {

    let id: Int
    let title: String
    let backdropPath: String

}

// MARK: Model to ViewModel conversion
extension MovieRecommendationViewModel {

    init(from model: MovieRecommendationModel) {
        id = model.id
        title = model.title
        backdropPath = model.backdropPath
    }

}
