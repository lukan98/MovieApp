import RealmSwift

class MovieLocalDataSourceModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var about: String
    @Persisted var posterSource: String
    @Persisted var genres: MutableSet<Int>
    @Persisted var isFavorited: Bool
    @Persisted var categories: MutableSet<CategoryDataSourceModel>

}

// MARK: Conversion from MovieRepositoryModel
extension MovieLocalDataSourceModel {

    convenience init(from model: MovieDataSourceModel, category: CategoryDataSourceModel) {
        self.init()

        id = model.id
        name = model.name
        about = model.about
        posterSource = model.posterSource
        model.genres.forEach { genres.insert($0) }
        categories.insert(category)
    }

}
