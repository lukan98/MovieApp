struct MovieRecommendationRepositoryModel {

    let id: Int
    let title: String
    let backdropPath: String

}

// MARK: DataSourceModel to RepositoryModel conversion
extension MovieRecommendationRepositoryModel {

    init(from model: MovieRecommendationDataSourceModel) {
        id = model.id
        title = model.title
        backdropPath = "https://image.tmdb.org/t/p/w780" + model.backdropPath
    }

}
