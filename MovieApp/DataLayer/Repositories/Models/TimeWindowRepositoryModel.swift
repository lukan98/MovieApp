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

    init(from model: TimeWindowModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

}
