import Foundation

struct ReviewDataSourceModel {

    let authorName: String
    let content: String
    let creationDate: Date
    let avatarPath: String

}

// MARK: ClientModel to DataSourceModel
extension ReviewDataSourceModel {

    init(from model: ReviewClientModel) {
        authorName = model.authorDetails.name ?? model.authorDetails.username
        content = model.content
        creationDate = Date(serverDate: model.creationDate) ?? .distantPast
        avatarPath = model.authorDetails.avatarPath
    }

}
