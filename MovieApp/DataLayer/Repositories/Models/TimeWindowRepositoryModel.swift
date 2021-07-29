enum TimeWindowRepositoryModel {
    case day
    case week
}

// MARK: Model conversion
extension TimeWindowRepositoryModel {

    init(from model: TimeWindowDataSourceModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

    func toDataSourceModel() -> TimeWindowDataSourceModel {
        switch self {
        case .day:
            return .day
        case .week:
            return .week
        }
    }
}
