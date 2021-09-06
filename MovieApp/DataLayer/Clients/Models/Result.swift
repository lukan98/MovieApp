enum Result<Success, Failure> where Failure: Error {

    case success(Success)
    case failure(Failure)

}

extension Result {

    func map<T>(mapper: (Success) -> T) -> Result<T, Failure> {
        switch self {
        case .success(let model):
            let mapped = mapper(model)
            return .success(mapped)
        case .failure(let error):
            return .failure(error)
        }
    }
}
