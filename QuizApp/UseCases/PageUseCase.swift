import UIKit
class PageUseCase : PageUseCaseProtocol {
    private var networkService : NetworkServiceProtocol!
    
    convenience init(networkService : NetworkServiceProtocol) {
        self.init()
        self.networkService = networkService
    }
    
    func sendResult(startTime : Double, quizId : Int, correct : Int ) {
        
        let diff = CFAbsoluteTimeGetCurrent() - startTime
        let complete = QuizComplete(correct: correct, quizId: quizId, time: diff)
        
        networkService.sendResult(complete) { (result: ServerResponse) in
            print(result.description)
        }
    }
}
