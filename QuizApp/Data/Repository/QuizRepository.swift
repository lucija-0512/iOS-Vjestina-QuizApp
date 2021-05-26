class QuizRepository: QuizRepositoryProtocol {

    private let networkDataSource: NetworkServiceProtocol
    private let coreDataSource: QuizCoreDataSourceProtocol

    init(networkDataSource: NetworkServiceProtocol, coreDataSource: QuizCoreDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.coreDataSource = coreDataSource
    }

    func fetchRemoteData() throws {
        print("in repository")
        networkDataSource.fetchQuizzes()  { quizzes in
            self.coreDataSource.saveNewQuizzes(quizzes)
               }
        //let quizzes = try networkDataSource.fetchQuizzes()
        print("save in repository")
        
    }

    func fetchLocalData() -> [Quiz] {
        coreDataSource.fetchQuizzesFromCoreData()
    }

}
