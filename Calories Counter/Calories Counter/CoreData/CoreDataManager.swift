//
//  CoreDataManager.swift
//  Calories Counter
//
//  Created by Mac Mini on 26/09/2025.
//


import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Context
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // MARK: - Save
    func saveBreakfast(name: String, calories: String, date: Date, image: UIImage?, details: String) -> Bool {
        let entity = Breakfast(context: context)
        entity.name = name
        entity.calories = calories
        entity.date = date
        entity.details = details
        entity.mealType = "Breakfast"
        if let img = image { entity.imageData = img.pngData() }
        return saveContext()
    }
    
    func saveLunch(name: String, calories: String, date: Date, image: UIImage?, details: String) -> Bool {
        let entity = Lunch(context: context)
        entity.name = name
        entity.calories = calories
        entity.date = date
        entity.details = details
        entity.mealType = "Lunch"
        if let img = image { entity.imageData = img.pngData() }
        return saveContext()
    }
    
    func saveSnack(name: String, calories: String, date: Date, image: UIImage?, details: String) -> Bool {
        let entity = Snacks(context: context)
        entity.name = name
        entity.calories = calories
        entity.date = date
        entity.details = details
        entity.mealType = "Snacks"
        if let img = image { entity.imageData = img.pngData() }
        return saveContext()
    }
    
    func saveDinner(name: String, calories: String, date: Date, image: UIImage?, details: String) -> Bool {
        let entity = Dinner(context: context)
        entity.name = name
        entity.calories = calories
        entity.date = date
        entity.details = details
        entity.mealType = "Dinner"
        if let img = image { entity.imageData = img.pngData() }
        return saveContext()
    }
    
    
    // MARK: - Fetch
    func fetchBreakfast() -> [Breakfast]? {
        let request: NSFetchRequest<Breakfast> = Breakfast.fetchRequest()
        return try? context.fetch(request)
    }
    
    func fetchLunch() -> [Lunch]? {
        let request: NSFetchRequest<Lunch> = Lunch.fetchRequest()
        return try? context.fetch(request)
    }
    
    func fetchSnacks() -> [Snacks]? {
        let request: NSFetchRequest<Snacks> = Snacks.fetchRequest()
        return try? context.fetch(request)
    }
    
    func fetchDinner() -> [Dinner]? {
        let request: NSFetchRequest<Dinner> = Dinner.fetchRequest()
        return try? context.fetch(request)
    }
    
    
    // MARK: - Delete All
    func deleteAllBreakfast() -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = Breakfast.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
            return saveContext()
        } catch {
            print("❌ DeleteAll Breakfast Error: \(error)")
            return false
        }
    }
    
    func deleteAllLunch() -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = Lunch.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
            return saveContext()
        } catch {
            print("❌ DeleteAll Lunch Error: \(error)")
            return false
        }
    }
    
    func deleteAllSnacks() -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = Snacks.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
            return saveContext()
        } catch {
            print("❌ DeleteAll Snacks Error: \(error)")
            return false
        }
    }
    
    func deleteAllDinner() -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = Dinner.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
            return saveContext()
        } catch {
            print("❌ DeleteAll Dinner Error: \(error)")
            return false
        }
    }
    
    
    // MARK: - Delete By Index
    func deleteBreakfast(at index: Int) -> Bool {
        guard let items = fetchBreakfast(), index < items.count else { return false }
        context.delete(items[index])
        return saveContext()
    }
    
    func deleteLunch(at index: Int) -> Bool {
        guard let items = fetchLunch(), index < items.count else { return false }
        context.delete(items[index])
        return saveContext()
    }
    
    func deleteSnack(at index: Int) -> Bool {
        guard let items = fetchSnacks(), index < items.count else { return false }
        context.delete(items[index])
        return saveContext()
    }
    
    func deleteDinner(at index: Int) -> Bool {
        guard let items = fetchDinner(), index < items.count else { return false }
        context.delete(items[index])
        return saveContext()
    }
    
    
    // MARK: - Save Context
    @discardableResult
    private func saveContext() -> Bool {
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                print("❌ Error saving CoreData: \(error)")
                return false
            }
        }
        return true
    }
}

