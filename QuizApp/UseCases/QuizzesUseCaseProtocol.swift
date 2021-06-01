protocol QuizzesUseCaseProtocol {
    func refreshData(completion: @escaping () -> Void)
    func getQuizzes() -> [Quiz]
    func filterQuizzes(name: String?) -> [Quiz] 
}
