import RealmSwift

class GenreLocalDataSourceModel: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String

}

// MARK: LocalDataSourceModel from and to DataSourceModel
extension GenreLocalDataSourceModel {

    convenience init(from model: GenreDataSourceModel) {
        self.init()

        id = model.id
        name = model.name
    }

    func toDataSourceModel() -> GenreDataSourceModel {
        GenreDataSourceModel(
            id: id,
            name: name)
    }

}
