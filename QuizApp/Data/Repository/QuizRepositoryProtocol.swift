protocol QuizRepositoryProtocol {
    func fetchRemoteData(completion: @escaping () -> Void)
    func fetchLocalData() -> [Quiz]
    func filterLocalData(name: String?) -> [Quiz]
}
