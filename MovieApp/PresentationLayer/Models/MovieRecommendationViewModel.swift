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

// MARK: Hashable
extension MovieRecommendationViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: MovieRecommendationViewModel, rhs: MovieRecommendationViewModel) -> Bool {
        lhs.id == rhs.id
    }

}
