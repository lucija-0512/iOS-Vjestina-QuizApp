protocol QuizzesUseCaseProtocol {
    func refreshData() throws
    func getQuizzes() -> [Quiz]
    func filterQuizzes(name: String?) -> [Quiz] 
}
