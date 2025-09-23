//
//  AI_Model.swift
//  Image Generation
//
//  Created by Mac Mini on 21/08/2025.
//

import Foundation
import GoogleGenerativeAI

struct FullUserHealthData {
    var gender: String
    var birthDate: String
    var calorieExperience: String
    var goal: String
    var unit: String
    var currentWeight: String
    var height: String
    var activityLevel: String
    var dietaryPreference: String
    var allergies: [String]
    var sleepHours: String
    var stressLevel: String
    var mealFrequency: String
    var waterIntake: String

    init() {
        self.gender = ""
        self.birthDate = ""
        self.calorieExperience = ""
        self.goal = ""
        self.unit = ""
        self.currentWeight = ""
        self.height = ""
        self.activityLevel = ""
        self.dietaryPreference = ""
        self.allergies = []
        self.sleepHours = ""
        self.stressLevel = ""
        self.mealFrequency = ""
        self.waterIntake = ""
    }
}



class HealthPlanAI {
    
    private let model = GenerativeModel(
        name: "gemini-2.0-flash",
        apiKey: "AIzaSyDta-ifnzs0YWl3nUsdwmpoQKKJDZMFzY8"
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
                - Gender: \(data.gender)
                - Birth Date: \(data.birthDate)
                - Calorie Experience: \(data.calorieExperience)
                - Goal: \(data.goal)
                - Unit: \(data.unit)
                - Current Weight: \(data.currentWeight)
                - Height: \(data.height)
                
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
