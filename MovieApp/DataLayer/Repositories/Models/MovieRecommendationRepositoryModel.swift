struct MovieRecommendationRepositoryModel {

    let title: String
    let backdropPath: String

}

// MARK: DataSourceModel to RepositoryModel conversion
extension MovieRecommendationRepositoryModel {

    init(from model: MovieRecommendationDataSourceModel) {
        title = model.title
        backdropPath = "https://image.tmdb.org/t/p/w780" + model.backdropPath
    }

}
