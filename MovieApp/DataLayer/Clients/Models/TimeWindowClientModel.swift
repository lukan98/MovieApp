enum TimeWindowClientModel: String {
    case day = "day"
    case week = "week"
}

// MARK: DataSource model to Client model conversion
extension TimeWindowClientModel {

    init(from model: TimeWindowDataSourceModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

}
