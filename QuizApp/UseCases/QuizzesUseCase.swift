import UIKit

class QuizzesUseCase : QuizzesUseCaseProtocol {
    
    

    private let quizRepository: QuizRepositoryProtocol


    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }
   
    func refreshData(completion: @escaping () -> Void) {
        quizRepository.fetchRemoteData() { () in
            completion()
        }
        
        
    }

    func getQuizzes() -> [Quiz] {
        quizRepository.fetchLocalData()
    }
    
    func filterQuizzes(name: String?) -> [Quiz] {
        quizRepository.filterLocalData(name: name)
    }
}
