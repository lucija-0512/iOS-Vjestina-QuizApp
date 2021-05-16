import UIKit

class NetworkService : NetworkServiceProtocol {
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                completionHandler(.failure(.clientError))
                return
            }
        
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
        
            guard let data = data else
            {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data) else
            {
                completionHandler(.failure(.dataDecodingError))
                return
            }
            completionHandler(.success(value))
        }
        dataTask.resume()
    }
    
    func executeUrlPostRequest(_ request: URLRequest, completionHandler: @escaping (ServerResponse) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
        
            guard let httpResponse = response as? HTTPURLResponse,
              let serverCode = ServerResponse(rawValue: httpResponse.statusCode) else { return }
            DispatchQueue.main.async {
                completionHandler(serverCode)
            }
        }
        dataTask.resume()
    }
}
