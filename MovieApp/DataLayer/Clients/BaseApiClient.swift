import Foundation

class BaseApiClient {

    private let baseUrl: String
    let apiKey = "e24dd8d2f3822e3917d10c6570d7f574"

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func get<T: Decodable>(
        path: String,
        queryParameters: [String: String?]? = nil,
        completionHandler: @escaping (Result<T, RequestError>) -> Void
    ) {
        var urlString = "\(baseUrl)\(path)"

        if let parameters = queryParameters {
            var parameterString = "?"
            for (index, (key, value)) in parameters.enumerated() {
                parameterString += "\(key)=\(value ?? "")"
                if index != parameters.count-1 {
                    parameterString.append("&")
                }
            }
            urlString.append(parameterString)
        }

        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURLError))
            return
        }

        let urlRequest = URLRequest(url: url)

        return executeURLRequest(urlRequest, completionHandler: completionHandler)
    }

    private func executeURLRequest<T: Decodable>(
        _ request: URLRequest,
        completionHandler: @escaping (Result<T, RequestError>) -> Void
    ) {
            URLSession.shared.dataTask(with: request) {
                (data, response, error) -> Void in

                guard error == nil else {
                    completionHandler(.failure(.clientError))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(.failure(.serverError))
                    return
                }

                guard let data = data else {
                    completionHandler(.failure(.noDataError))
                    return
                }

                guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                    completionHandler(.failure(.dataDecodingError))
                    return
                }

                completionHandler(.success(value))
            }.resume()
        }

}
