import CoreData
import UIKit

extension Quiz {

    init(with entity: CDQuiz) {
        id = Int(entity.identifier)
        title = entity.title
        description = entity.quizDescription
        category = QuizCategory(rawValue: entity.category)!
        level = Int(entity.level)
        imageUrl = entity.image
        var temp = [Question]()
        for question in entity.questions{
            temp.append(Question(with: question))
        }
        questions = temp
    }

    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.identifier = Int32(id)
        entity.title = title
        entity.quizDescription = description
        entity.category = category.rawValue
        entity.level = Int32(level)
        entity.image = imageUrl
        entity.questions.removeAll()
        for question in questions {
            let cdQuestion = CDQuestion(context: context)
            question.populate(cdQuestion)
            entity.questions.insert(cdQuestion)
        }
    }

}
