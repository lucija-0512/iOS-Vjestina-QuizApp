protocol QuizzesUseCaseProtocol {
    //func fetchQuizzes(completion: @escaping (Quizzes)-> Void )
    func refreshData() throws
    func getQuizzes() -> [Quiz]
}
