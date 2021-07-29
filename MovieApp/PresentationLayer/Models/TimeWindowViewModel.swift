enum TimeWindowViewModel: Int {
    case day
    case week
}

// MARK: Model to ViewModel conversion
extension TimeWindowViewModel {

    init(from model: TimeWindowModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

    func toModel() -> TimeWindowModel {
        switch self {
        case .day:
            return TimeWindowModel.day
        case .week:
            return TimeWindowModel.week
        }
    }

}
