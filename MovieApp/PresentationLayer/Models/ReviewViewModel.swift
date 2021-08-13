struct ReviewViewModel {

    let authorName: String
    let avatarPath: String
    let date: String
    let content: String

}

// MARK: Model to ViewModel conversion
extension ReviewViewModel {

    init(from model: ReviewModel) {
        authorName = model.authorName
        avatarPath = model.avatarPath
        date = model.creationDate.uiDate
        content = model.content
    }

}
