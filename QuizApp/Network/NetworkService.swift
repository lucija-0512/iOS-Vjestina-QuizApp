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
    
    func sendResult(_ result: QuizComplete, completionHandler: @escaping (ServerResponse) -> Void) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else { return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "Token") as! String
        let userId = defaults.object(forKey: "UserId") as! Int
        request.setValue(token, forHTTPHeaderField: "Authorization")
        let json: [String: Any] = ["quiz_id": result.quizId,
                                   "user_id": userId,
                                   "time": result.time,
                                   "no_of_correct": result.correct]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        print(json)
        request.httpBody = jsonData
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
