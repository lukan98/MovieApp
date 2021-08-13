import Foundation

struct ReviewRepositoryModel {

    let authorName: String
    let content: String
    let creationDate: Date
    let avatarPath: String

}

// MARK: DataSourceModel to RepositoryModel conversion
extension ReviewRepositoryModel {

    init(from model: ReviewDataSourceModel) {
        authorName = model.authorName
        content = model.content
        creationDate = model.creationDate
        if model.avatarPath.starts(with: "/http") {
            avatarPath = (model.avatarPath as NSString).substring(from: 1)
        } else {
            avatarPath = "https://image.tmdb.org/t/p/w185" + model.avatarPath
        }
    }

}
