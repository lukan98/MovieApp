import RealmSwift

class MovieLocalRepositoryModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var about: String
    @Persisted var posterSource: String
    @Persisted var genres: List<Int>
    @Persisted var isFavorited: Bool

}

// MARK: Conversion from MovieRepositoryModel
extension MovieLocalRepositoryModel {

    convenience init(from model: MovieRepositoryModel) {
        self.init()

        id = model.id
        about = model.about
        posterSource = model.posterSource
        model.genres.forEach { genres.append($0) }
    }

}
