//
//  CDQuestion+CoreDataProperties.swift
//  
//
//  Created by five on 25/05/2021.
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var question: String
    @NSManaged public var answers: [NSString]
    @NSManaged public var correct: Int32
    @NSManaged public var quiz: CDQuiz

}
