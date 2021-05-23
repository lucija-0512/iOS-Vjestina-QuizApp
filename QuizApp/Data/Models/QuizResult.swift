struct QuizResult {
    let correct : Int
    let total : Int
    let quizId : Int
    
    init(correct: Int, total: Int, quizId: Int) {
            self.correct   = correct
            self.total = total
            self.quizId  = quizId
        }
}
