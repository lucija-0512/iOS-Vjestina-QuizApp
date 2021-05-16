import UIKit
class PageUseCase : PageUseCaseProtocol {
    private var networkService : NetworkServiceProtocol!
    
    convenience init(networkService : NetworkServiceProtocol) {
        self.init()
        self.networkService = networkService
    }
    
    func sendResult(startTime : Double, quizId : Int, correct : Int ) {
        
        let diff = CFAbsoluteTimeGetCurrent() - startTime
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else { return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "Token") as! String
        let userId = defaults.object(forKey: "UserId") as! Int
        request.setValue(token, forHTTPHeaderField: "Authorization")
        let json: [String: Any] = ["quiz_id": quizId,
                                   "user_id": userId,
                                   "time": diff,
                                   "no_of_correct": correct]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        print(json)
        request.httpBody = jsonData
        
        networkService.executeUrlPostRequest(request) { (result: ServerResponse) in
            switch result {
                case .unauthorized:
                    print("401 UNAUTHORIZED")
                case .forbidden:
                    print("403 FORBIDDEN ")
                case .notFound:
                    print("404 NOT FOUND")
                case .badRequest:
                    print("400 BAD REQUEST")
                case .ok:
                    print("200 OK")
            }
        }
    }
}
