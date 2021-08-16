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
        authorName = model.authorDetails.name.isEmpty ? model.authorDetails.username: model.authorDetails.name
        content = model.content
        creationDate = Date(iso8601Date: model.creationDate) ?? .distantPast
        avatarPath = model.authorDetails.avatarPath ?? ""
    }

}
