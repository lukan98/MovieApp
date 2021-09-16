enum CategoryRepositoryModel {
    case popular
    case topRated
    case trendingWeekly
    case trendingDaily
}

// MARK: Conversion to DataSource Model
extension CategoryRepositoryModel {

    func toDataSourceModel() -> CategoryDataSourceModel {
        switch self {
        case .popular:
            return .popular
        case .topRated:
            return .topRated
        case .trendingDaily:
            return .trendingDaily
        case .trendingWeekly:
            return .trendingWeekly
        }
    }

}
