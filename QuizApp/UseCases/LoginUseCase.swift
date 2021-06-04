import UIKit
class LoginUseCase : LoginUseCaseProtocol {
    private var networkService : NetworkServiceProtocol!
    
    convenience init(networkService : NetworkServiceProtocol) {
        self.init()
        self.networkService = networkService
    }
    
    func checkLogin(name : String, password : String, router : AppRouterProtocol, completion: @escaping (Session)-> Void) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(name)&password=\(password)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(request) { (result: Result<Session, RequestError>) in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    print(value)
                    completion(value)
            }
        }
    }
}
