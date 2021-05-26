import UIKit

class QuizzesUseCase : QuizzesUseCaseProtocol {
    
//    private var networkService : NetworkServiceProtocol!
//
//    convenience init(networkService : NetworkServiceProtocol) {
//        self.init()
//        self.networkService = networkService
//    }
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
//    func fetchQuizzes(completion: @escaping (Quizzes)-> Void ) {
//        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else { return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        networkService.executeUrlRequest(request) { (result: Result<Quizzes, RequestError>) in
//            switch result {
//                        case .failure(let error):
//                            print(error)
//                        case .success(let value):
//                            completion(value)
//
//                }
//        }
//    }
}
