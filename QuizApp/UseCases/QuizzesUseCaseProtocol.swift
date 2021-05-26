protocol QuizzesUseCaseProtocol {
    func refreshData() throws
    func getQuizzes() -> [Quiz]
}
