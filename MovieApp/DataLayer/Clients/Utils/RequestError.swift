enum RequestError: Error {

    case clientError
    case serverError
    case dataDecodingError
    case noDataError
    case invalidURLError
    
}
