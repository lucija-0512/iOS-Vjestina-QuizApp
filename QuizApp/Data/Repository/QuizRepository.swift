class QuizRepository: QuizRepositoryProtocol {

    private let networkDataSource: NetworkServiceProtocol
    private let coreDataSource: QuizCoreDataSourceProtocol

    init(networkDataSource: NetworkServiceProtocol, coreDataSource: QuizCoreDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.coreDataSource = coreDataSource
    }

    func fetchRemoteData(completion: @escaping () -> Void) {
        networkDataSource.fetchQuizzes()  { quizzes in
            if !quizzes.isEmpty {
                self.coreDataSource.saveNewQuizzes(quizzes)
            }
            completion()
       }
    }
    
    func filterLocalData(name: String?) -> [Quiz] {
        coreDataSource.filterQuizzesFromCoreData(name: name)
    }

    func fetchLocalData() -> [Quiz] {
        coreDataSource.fetchQuizzesFromCoreData()
    }

}
