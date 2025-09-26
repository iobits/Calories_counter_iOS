//
//  Lunch+CoreDataProperties.swift
//  
//
//  Created by Mac Mini on 26/09/2025.
//
//

import Foundation
import CoreData


extension Lunch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lunch> {
        return NSFetchRequest<Lunch>(entityName: "Lunch")
    }

    @NSManaged public var calories: String?
    @NSManaged public var date: Date?
    @NSManaged public var imageData: Data?
    @NSManaged public var mealType: String?
    @NSManaged public var name: String?
    @NSManaged public var details: String?

}
