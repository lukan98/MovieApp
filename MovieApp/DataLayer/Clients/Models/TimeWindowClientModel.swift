enum TimeWindowClientModel: String {
    case day
    case week
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
