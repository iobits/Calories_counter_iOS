//
//  Dinner+CoreDataProperties.swift
//  
//
//  Created by Mac Mini on 26/09/2025.
//
//

import Foundation
import CoreData


extension Dinner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dinner> {
        return NSFetchRequest<Dinner>(entityName: "Dinner")
    }

    @NSManaged public var calories: String?
    @NSManaged public var date: Date?
    @NSManaged public var imageData: Data?
    @NSManaged public var mealType: String?
    @NSManaged public var name: String?
    @NSManaged public var details: String?

}
