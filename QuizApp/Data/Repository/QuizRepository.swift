class QuizRepository: QuizRepositoryProtocol {

    private let networkDataSource: NetworkServiceProtocol
    private let coreDataSource: QuizCoreDataSourceProtocol

    init(networkDataSource: NetworkServiceProtocol, coreDataSource: QuizCoreDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.coreDataSource = coreDataSource
    }

    func fetchRemoteData() throws {
        networkDataSource.fetchQuizzes()  { quizzes in
            self.coreDataSource.saveNewQuizzes(quizzes)
               }
    }
    
    func filterLocalData(name: String?) -> [Quiz] {
        coreDataSource.filterQuizzesFromCoreData(name: name)
    }

    func fetchLocalData() -> [Quiz] {
        coreDataSource.fetchQuizzesFromCoreData()
    }

}
