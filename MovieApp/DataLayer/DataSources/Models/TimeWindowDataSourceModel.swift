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

    func toClientModel() -> TimeWindowClientModel {
        switch self {
        case .day:
            return .day
        case .week:
            return .week
        }
    }

}
