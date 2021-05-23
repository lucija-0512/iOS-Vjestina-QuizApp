protocol QuizzesUseCaseProtocol {
    func fetchQuizzes(completion: @escaping (Quizzes)-> Void )
}
