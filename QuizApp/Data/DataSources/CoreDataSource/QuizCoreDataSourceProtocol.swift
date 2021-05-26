protocol QuizCoreDataSourceProtocol {
    func fetchQuizzesFromCoreData() -> [Quiz]
    func saveNewQuizzes(_ quizzes: [Quiz])
}
