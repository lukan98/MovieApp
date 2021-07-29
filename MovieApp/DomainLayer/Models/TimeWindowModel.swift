enum TimeWindowModel {
    case day
    case week
}

// MARK: Model conversion
extension TimeWindowModel {

    init(from model: TimeWindowModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

    init(from model: TimeWindowViewModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

}
