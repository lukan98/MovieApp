struct MovieRecommendationDataSourceModel {

    let id: Int
    let title: String
    let backdropPath: String

}

// MARK: ClientModel to DataSouceModel conversion
extension MovieRecommendationDataSourceModel {

    init(from model: MovieRecommendationClientModel) {
        id = model.id
        title = model.title
        backdropPath = model.backdropPath ?? ""
    }

}
