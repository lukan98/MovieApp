import RealmSwift
import Foundation

class DetailedMovieLocalDataSourceModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var about: String
    @Persisted var name: String
    @Persisted var posterSource: String
    @Persisted var genres: MutableSet<GenreLocalDataSourceModel>
    @Persisted var voteAverage: Double
    @Persisted var runtime: Int
    @Persisted var releaseDate: Date

}

// MARK: Conversion to and from DataSourceModel
extension DetailedMovieLocalDataSourceModel {

    convenience init(from model: DetailedMovieDataSourceModel) {
        self.init()

        id = model.id
        about = model.about
        name = model.name
        posterSource = model.posterSource
        model.genres.forEach { genres.insert( GenreLocalDataSourceModel(from: $0)) }
        voteAverage = model.voteAverage
        runtime = model.runtime
        releaseDate = model.releaseDate
    }

    func toDataSourceModel() -> DetailedMovieDataSourceModel {
        DetailedMovieDataSourceModel(
            id: id,
            about: about,
            name: name,
            posterSource: posterSource,
            genres: genres.map { $0.toDataSourceModel() },
            voteAverage: voteAverage,
            runtime: runtime,
            releaseDate: releaseDate)
    }

}
