struct QuizComplete {
    let correct : Int
    let quizId : Int
    let time : Double
    
    init(correct: Int, quizId: Int, time: Double) {
            self.correct   = correct
            self.quizId = quizId
            self.time = time
        }
}
