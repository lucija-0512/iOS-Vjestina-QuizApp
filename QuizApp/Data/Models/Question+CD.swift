import CoreData

extension Question {

    init(with entity: CDQuestion) {
        id = Int(entity.identifier)
        question = entity.question
        answers = entity.answers as! [String]
        correctAnswer = Int(entity.correct)
    }

    func populate(_ entity: CDQuestion) {
        entity.identifier = Int32(id)
        entity.question = question
        let array = NSArray(array: answers)
        entity.answers.removeAll()
        for p in 0..<array.count
        {
            entity.answers.append(array[p] as! NSString)
        }
        entity.correct = Int32(correctAnswer)
    }

}
