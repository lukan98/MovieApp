import RealmSwift

enum CategoryDataSourceModel: Int, RealmCollectionValue, PersistableEnum {
    case popular
    case topRated
    case trendingDaily
    case trendingWeekly
}

// MARK: Conversion from TimeWindowModel
extension CategoryDataSourceModel {

    init(from model: TimeWindowRepositoryModel) {
        switch model {
        case .day:
            self = .trendingDaily
        case .week:
            self = .trendingWeekly
        }
    }

}
