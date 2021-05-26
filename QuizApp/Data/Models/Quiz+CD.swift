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
        //questions = [Question]()
        for question in entity.questions{
            temp.append(Question(with: question))
        }
        print("temp")
        print(temp)
        questions = temp
    }

    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.identifier = Int32(id)
        entity.title = title
        entity.quizDescription = description
        entity.category = category.rawValue
        entity.level = Int32(level)
        entity.image = imageUrl
        //print("questions")
        //print(questions)
        //var temp = [CDQuestion]()
        for question in questions {
            let cdQuestion = CDQuestion(context: context)
            question.populate(cdQuestion)
            entity.questions.insert(cdQuestion)
        }
        //entity.questions = NSSet(objects: temp)
        
    }

}
