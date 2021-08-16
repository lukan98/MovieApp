struct MovieRecommendationDataSourceModel {

    let title: String
    let backdropPath: String

}

// MARK: ClientModel to DataSouceModel conversion
extension MovieRecommendationDataSourceModel {

    init(from model: MovieRecommendationClientModel) {
        title = model.title
        backdropPath = model.backdropPath ?? ""
    }

}
