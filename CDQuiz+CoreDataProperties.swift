//
//  CDQuiz+CoreDataProperties.swift
//  
//
//  Created by five on 25/05/2021.
//
//

import Foundation
import CoreData


extension CDQuiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuiz> {
        return NSFetchRequest<CDQuiz>(entityName: "CDQuiz")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var title: String
    @NSManaged public var image: String
    @NSManaged public var quizDescription: String
    @NSManaged public var level: Int32
    @NSManaged public var category: String
    @NSManaged public var questions: Set<CDQuestion>

}

// MARK: Generated accessors for questions
extension CDQuiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: CDQuestion)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: CDQuestion)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
