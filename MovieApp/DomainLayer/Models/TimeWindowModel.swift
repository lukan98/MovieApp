enum TimeWindowModel {
    case day
    case week
}

// MARK: RepositoryModel to Model conversion
extension TimeWindowModel {

    init(from model: TimeWindowRepositoryModel) {
        switch model {
        case .day:
            self = .day
        case .week:
            self = .week
        }
    }

}
