import Foundation

class BaseApiClient {

    private let apiKey = "e24dd8d2f3822e3917d10c6570d7f574"
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func get<T: Decodable>(
        path: String,
        queryParameters: [String: String?]? = nil,
        completionHandler: @escaping (Result<T, RequestError>) -> Void
    ) {
        let urlString = "\(baseUrl)\(path)"

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]

        if let parameters = queryParameters {
            for parameter in parameters {
                urlComponents?.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
        }

        guard let url = urlComponents?.url else {
            completionHandler(.failure(.invalidURLError))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

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
