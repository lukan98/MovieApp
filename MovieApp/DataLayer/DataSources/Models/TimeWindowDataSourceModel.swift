enum TimeWindowDataSourceModel {
    case day
    case week
}

// MARK: Model conversion
extension TimeWindowDataSourceModel {

    init(from model: TimeWindowClientModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

    init(from model: TimeWindowRepositoryModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

}
