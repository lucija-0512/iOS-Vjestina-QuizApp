import UIKit
class QuizResultUseCase : QuizResultUseCaseProtocol {
    
    private var networkService : NetworkServiceProtocol!
    
    convenience init(networkService : NetworkServiceProtocol) {
        self.init()
        self.networkService = networkService
    }
    
    func getLeaderboard(quizId : Int, router : AppRouterProtocol) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "Token") as! String
        request.setValue(token, forHTTPHeaderField: "Authorization")
        networkService.executeUrlRequest(request) { (result: Result<[LeaderboardResult], RequestError>) in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    DispatchQueue.main.async {
                        router.presentLeaderboardViewController(board: value)
                    }
            }
        }
    }
    
    
}
