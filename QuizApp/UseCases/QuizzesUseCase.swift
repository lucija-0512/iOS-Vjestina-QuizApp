import UIKit

class QuizzesUseCase : QuizzesUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol


    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }
   
    func refreshData() throws {
        try quizRepository.fetchRemoteData()
    }

    func getQuizzes() -> [Quiz] {
        quizRepository.fetchLocalData()
    }
}
