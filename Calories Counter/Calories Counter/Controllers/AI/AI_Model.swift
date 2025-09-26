//
//  AI_Model.swift
//  Image Generation
//
//  Created by Mac Mini on 21/08/2025.
//

import Foundation
import GoogleGenerativeAI

// MARK: - Keys Manager
class DefaultKeys {
    static let shared = DefaultKeys()
    
    let gender = "gender"
    let birthDate = "birthDate"
    let countCalBefore = "countCalBefore"
    let goal = "goal"
    let unit = "unit"
    let currentWeight = "currentWeight"
    let targetWeight = "targetWeight"
    let height = "height"
    let motivation = "motivation"
    let obstacles = "obstacles"
    let lifestyle = "lifestyle"
    let workouts = "workouts"
    let goalSpeed = "goalSpeed"
    let trackingConsistency = "trackingConsistency"
    let mealTrackingMethod = "mealTrackingMethod"
    let badEatingHabits = "badEatingHabits"
    let dietType = "dietType"
    let dietaryRestrictions = "dietaryRestrictions"
    let mealInADay = "mealInADay"
    let intermittentFasting = "intermittentFasting"
    let mealTiming = "mealTiming"
    let eatOut = "eatOut"
    let weekendEating = "weekendEating"
    
    
    
    let mealType = "mealType"
}

struct FullUserHealthData {
    var gender: String
    var birthDate: String
    var countCalBefore: String
    var goal: String
    var unit: String
    var currentWeight: String
    var targetWeight: String
    var height: String
    var motivation: String
    var obstacles: String
    var lifestyle: String
    var workouts: String
    var goalSpeed: String
    var trackingConsistency: String
    var mealTrackingMethod: String
    var badEatingHabits: String
    var dietType: String
    var dietaryRestrictions: String
    var mealInADay: String
    var intermittentFasting: String
    var mealTiming: String
    var eatOut: String
    var weekendEating: String
    
    init() {
        self.gender = ""
        self.birthDate = ""
        self.countCalBefore = ""
        self.goal = ""
        self.unit = ""
        self.currentWeight = ""
        self.targetWeight = ""
        self.height = ""
        self.motivation = ""
        self.obstacles = ""
        self.lifestyle = ""
        self.workouts = ""
        self.goalSpeed = ""
        self.trackingConsistency = ""
        self.mealTrackingMethod = ""
        self.badEatingHabits = ""
        self.dietType = ""
        self.dietaryRestrictions = ""
        self.mealInADay = ""
        self.intermittentFasting = ""
        self.mealTiming = ""
        self.eatOut = ""
        self.weekendEating = ""
    }
    
    
    // MARK: Load data from UserDefaults
    static func load() -> FullUserHealthData {
        let d = UserDefaults.standard
        let k = DefaultKeys.shared
        var data = FullUserHealthData()
        
        data.gender = d.string(forKey: k.gender) ?? ""
        data.birthDate = d.string(forKey: k.birthDate) ?? ""
        data.countCalBefore = d.string(forKey: k.countCalBefore) ?? ""
        data.goal = d.string(forKey: k.goal) ?? ""
        data.unit = d.string(forKey: k.unit) ?? ""
        data.currentWeight = d.string(forKey: k.currentWeight) ?? ""
        data.targetWeight = d.string(forKey: k.targetWeight) ?? ""
        data.height = d.string(forKey: k.height) ?? ""
        data.motivation = d.string(forKey: k.motivation) ?? ""
        data.obstacles = d.string(forKey: k.obstacles) ?? ""
        data.lifestyle = d.string(forKey: k.lifestyle) ?? ""
        data.workouts = d.string(forKey: k.workouts) ?? ""
        data.goalSpeed = d.string(forKey: k.goalSpeed) ?? ""
        data.trackingConsistency = d.string(forKey: k.trackingConsistency) ?? ""
        data.mealTrackingMethod = d.string(forKey: k.mealTrackingMethod) ?? ""
        data.badEatingHabits = d.string(forKey: k.badEatingHabits) ?? ""
        data.dietType = d.string(forKey: k.dietType) ?? ""
        data.dietaryRestrictions = d.string(forKey: k.dietaryRestrictions) ?? ""
        data.mealInADay = d.string(forKey: k.mealInADay) ?? ""
        data.intermittentFasting = d.string(forKey: k.intermittentFasting) ?? ""
        data.mealTiming = d.string(forKey: k.mealTiming) ?? ""
        data.eatOut = d.string(forKey: k.eatOut) ?? ""
        data.weekendEating = d.string(forKey: k.weekendEating) ?? ""
        
        return data
    }
    
    // MARK: Delete all saved values
    static func delete() {
        let d = UserDefaults.standard
        let k = DefaultKeys.shared
        
        d.removeObject(forKey: k.gender)
        d.removeObject(forKey: k.birthDate)
        d.removeObject(forKey: k.countCalBefore)
        d.removeObject(forKey: k.goal)
        d.removeObject(forKey: k.unit)
        d.removeObject(forKey: k.currentWeight)
        d.removeObject(forKey: k.targetWeight)
        d.removeObject(forKey: k.height)
        d.removeObject(forKey: k.motivation)
        d.removeObject(forKey: k.obstacles)
        d.removeObject(forKey: k.lifestyle)
        d.removeObject(forKey: k.workouts)
        d.removeObject(forKey: k.goalSpeed)
        d.removeObject(forKey: k.trackingConsistency)
        d.removeObject(forKey: k.mealTrackingMethod)
        d.removeObject(forKey: k.badEatingHabits)
        d.removeObject(forKey: k.dietType)
        d.removeObject(forKey: k.dietaryRestrictions)
        d.removeObject(forKey: k.mealInADay)
        d.removeObject(forKey: k.intermittentFasting)
        d.removeObject(forKey: k.mealTiming)
        d.removeObject(forKey: k.eatOut)
        d.removeObject(forKey: k.weekendEating)
    }
}


class HealthPlanAI {
    
    private let model = GenerativeModel(
        name: "gemini-2.5-flash",
        apiKey: "AIzaSyA0UR0XwHLQICBMdkBzbKF8xYr7opGbEYg"
    )
    
    /// Generate health plan based on user survey data
    func generateHealthPlan(for data: FullUserHealthData, completion: @escaping (String?) -> Void) {
        Task {
            do {
                let instruction = """
                You are a nutrition AI assistant. 
                Based on the provided user data, calculate and return a personalized health plan 
                in the following exact format (no extra explanation, just structured output):
                
                Carbs: [grams] g ([percentage]%)
                Protein: [grams] g ([percentage]%)
                Fat: [grams] g ([percentage]%)
                
                Daily Calorie Goal: [kcal]/day
                Goal Weight: [target weight] by [target date]
                
                Example:
                Carbs: 188 g (45%)
                Protein: 281 g (30%)
                Fat: 69 g (25%)
                
                Daily Calorie Goal: 2500 kcal/day
                Goal Weight: 75 kg by January 18, 2026
                
                ---
                User Data:
                - What is your gender: \(data.gender)
                - How old are you?: \(data.birthDate)
                - Have you counted calories before?: \(data.countCalBefore)
                - What goal do you plan to achieve?: \(data.goal)
                - What's your units?: \(data.unit)
                - What is your current weight?: \(data.currentWeight)
                - What is your target weight?: \(data.targetWeight)
                - What is your height?: \(data.height)
                - What motivates you on the way to your goal?: \(data.motivation)
                - What’s stopping you from reaching your goals?: \(data.obstacles)
                - What's your lifestyle like?: \(data.lifestyle)
                - Do you do any workouts?: \(data.workouts)
                - How fast do you want to reach your goal?: \(data.goalSpeed)
                - How many days in row can you track your nutrition: \(data.trackingConsistency)
                - How do you plan to track your meals? \(data.mealTrackingMethod)
                - We all have some bad eating habits. What are your? \(data.badEatingHabits)
                - What’s your diet type? \(data.dietType)
                - Do you have any dietary restrictions we should know about? \(data.dietaryRestrictions)
                - How many meals do you eat a day? \(data.mealInADay)
                - Have you tried intermittent fasting? \(data.intermittentFasting)
                - When do you usually eat the first and last meal of the da? \(data.mealTiming)
                - Do you eat out? \(data.eatOut)
                - Wanna eat a bit more on weekends? \(data.weekendEating)
                
                Final Health Plan:
                """
                
                let response = try await model.generateContent(instruction)
                completion(response.text?.trimmingCharacters(in: .whitespacesAndNewlines))
                
            } catch {
                print("❌ Health plan generation failed: \(error)")
                completion(nil)
            }
        }
    }
}

class AI_MODEL {
    // MARK: - this key is generated by tanv33r.ab@gmail.com in ss-apps FB project
    let model = GenerativeModel(name: "gemini-2.5-flash", apiKey: "AIzaSyA0UR0XwHLQICBMdkBzbKF8xYr7opGbEYg")
    var task: Task<Void, Never>?
    
    var prefix = """
    You are a nutrition vision AI. Analyze the given food image and return the details in this exact format:

    Dish Name: [Detected Dish with quantity if visible]
    Total Calories: [number only] kcal

    Carbs: [grams only] g ([percentage]%)
    Protein: [grams only] g ([percentage]%)
    Fat: [grams only] g ([percentage]%)

    Details:
    - [Line 1 about nutrition/benefit]
    - [Line 2 about health/use]
    - [Line 3 ...]
    - [At least 7 lines total]

    Example:
    Dish Name: Tandoori chicken with rice and salad
    Total Calories: 458 kcal

    Carbs: 109 g (55%)
    Protein: 52 g (26%)
    Fat: 52 g (28%)

    Details:
    - High in protein due to chicken, supporting muscle growth
    - Provides balanced carbs from rice for energy
    - Rich in spices like turmeric with anti-inflammatory properties
    - Contains fresh salad offering vitamins and fiber
    - Supports digestive health with fiber content
    - Moderate calorie meal ideal for lunch
    - Popular South Asian dish enjoyed worldwide

    Final Answer:
    """

}


struct NutritionResult {
    var dishName: String
    var calories: Int
    var carbsGrams: Float
    var carbsPercent: Int
    var proteinGrams: Float
    var proteinPercent: Int
    var fatGrams: Float
    var fatPercent: Int
    var details: [String]
}

func parseAIResponse(_ response: String) -> NutritionResult? {
    let lines = response.components(separatedBy: "\n").map { $0.trimmingCharacters(in: .whitespaces) }

    var dishName = ""
    var calories = 0
    var carbsGrams: Float = 0
    var carbsPercent = 0
    var proteinGrams: Float = 0
    var proteinPercent = 0
    var fatGrams: Float = 0
    var fatPercent = 0
    var details: [String] = []

    for line in lines {
        if line.starts(with: "Dish Name:") {
            dishName = line.replacingOccurrences(of: "Dish Name:", with: "").trimmingCharacters(in: .whitespaces)
        } else if line.starts(with: "Total Calories:") {
            if let val = line.components(separatedBy: " ").first(where: { Int($0) != nil }),
               let cal = Int(val) {
                calories = cal
            }
        } else if line.starts(with: "Carbs:") {
            let parts = line.replacingOccurrences(of: "Carbs:", with: "").components(separatedBy: "(")
            if let grams = parts.first?.components(separatedBy: "g").first?.trimmingCharacters(in: .whitespaces),
               let g = Float(grams) {
                carbsGrams = g
            }
            if let percentStr = parts.last?.replacingOccurrences(of: "%)", with: "").trimmingCharacters(in: .whitespaces),
               let p = Int(percentStr) {
                carbsPercent = p
            }
        } else if line.starts(with: "Protein:") {
            let parts = line.replacingOccurrences(of: "Protein:", with: "").components(separatedBy: "(")
            if let grams = parts.first?.components(separatedBy: "g").first?.trimmingCharacters(in: .whitespaces),
               let g = Float(grams) {
                proteinGrams = g
            }
            if let percentStr = parts.last?.replacingOccurrences(of: "%)", with: "").trimmingCharacters(in: .whitespaces),
               let p = Int(percentStr) {
                proteinPercent = p
            }
        } else if line.starts(with: "Fat:") {
            let parts = line.replacingOccurrences(of: "Fat:", with: "").components(separatedBy: "(")
            if let grams = parts.first?.components(separatedBy: "g").first?.trimmingCharacters(in: .whitespaces),
               let g = Float(grams) {
                fatGrams = g
            }
            if let percentStr = parts.last?.replacingOccurrences(of: "%)", with: "").trimmingCharacters(in: .whitespaces),
               let p = Int(percentStr) {
                fatPercent = p
            }
        } else if line.starts(with: "-") {
            details.append(line.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespaces))
        }
    }

    return NutritionResult(
        dishName: dishName,
        calories: calories,
        carbsGrams: carbsGrams,
        carbsPercent: carbsPercent,
        proteinGrams: proteinGrams,
        proteinPercent: proteinPercent,
        fatGrams: fatGrams,
        fatPercent: fatPercent,
        details: details
    )
}
