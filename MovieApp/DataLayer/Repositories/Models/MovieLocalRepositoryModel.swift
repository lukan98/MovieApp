import RealmSwift

class MovieLocalRepositoryModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var about: String
    @Persisted var posterSource: String
    @Persisted var genres: MutableSet<Int>
    @Persisted var isFavorited: Bool
    @Persisted var categories: MutableSet<CategoryRepositoryModel>

}

// MARK: Conversion from MovieRepositoryModel
extension MovieLocalRepositoryModel {

    convenience init(from model: MovieRepositoryModel, category: CategoryRepositoryModel) {
        self.init()

        id = model.id
        name = model.name
        about = model.about
        posterSource = model.posterSource
        model.genres.forEach { genres.insert($0) }
        categories.insert(category)
    }

}
