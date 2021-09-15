import RealmSwift

enum CategoryRepositoryModel: Int, RealmCollectionValue, PersistableEnum {
    case popular
    case topRated
    case trendingDaily
    case trendingWeekly
}

// MARK: Conversion from TimeWindowModel
extension CategoryRepositoryModel {

    init(from model: TimeWindowRepositoryModel) {
        switch model {
        case .day:
            self = .trendingDaily
        case .week:
            self = .trendingWeekly
        }
    }

}
