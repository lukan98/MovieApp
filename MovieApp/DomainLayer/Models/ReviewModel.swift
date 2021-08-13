import Foundation

struct ReviewModel {

    let authorName: String
    let content: String
    let creationDate: Date
    let avatarPath: String

}

// MARK: RepositoryModel to Model conversion
extension ReviewModel {

    init(from model: ReviewRepositoryModel) {
        authorName = model.authorName
        content = model.content
        creationDate = model.creationDate
        avatarPath = model.avatarPath
    }

}
