protocol QuizRepositoryProtocol {
    func fetchRemoteData() throws
    func fetchLocalData() -> [Quiz] 
}
