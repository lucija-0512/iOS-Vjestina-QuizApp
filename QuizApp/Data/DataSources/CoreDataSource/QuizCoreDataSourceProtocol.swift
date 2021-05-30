protocol QuizCoreDataSourceProtocol {
    func fetchQuizzesFromCoreData() -> [Quiz]
    func saveNewQuizzes(_ quizzes: [Quiz])
    func filterQuizzesFromCoreData(name: String?) -> [Quiz] 
}
