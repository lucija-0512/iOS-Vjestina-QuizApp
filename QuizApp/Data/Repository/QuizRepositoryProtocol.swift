protocol QuizRepositoryProtocol {
    func fetchRemoteData() throws
    func fetchLocalData() -> [Quiz]
    func filterLocalData(name: String?) -> [Quiz]
}
