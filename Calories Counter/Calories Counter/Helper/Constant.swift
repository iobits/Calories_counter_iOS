//
//  Extension.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit


struct BadEatingObj {
    var img: String
    var titleSt: String
}

struct MotivateObj {
    var img: String
    var titleSt: String
}

struct LikeObj {
    var img: String
    var titleSt: String
    var detailSt: String
}

struct bitMoreWeekends {
    var img: String
    var titleSt: String
}

struct TrackYourNutrition {
    var img: String
    var titleSt: String
    var detailSt: String
}

struct TrackYourMeal {
    var titleSt: String
    var detailSt: String
}

struct DietType {
    var img: String
    var titleSt: String
    var detailSt: String
}


class Constant: NSObject{
    // Array of MotivateObj
    static let shared = Constant()
    let motivateArr: [MotivateObj] = [
        MotivateObj(img: "g1", titleSt: "Look better"),
        MotivateObj(img: "g2", titleSt: "Feel more confident"),
        MotivateObj(img: "g3", titleSt: "Special occasion"),
        MotivateObj(img: "g4", titleSt: "Improve health"),
        MotivateObj(img: "g5", titleSt: "Boost energy"),
        MotivateObj(img: "g6", titleSt: "Release Stress"),
        MotivateObj(img: "g7", titleSt: "Improve immune system"),
        MotivateObj(img: "g8", titleSt: "Improve mental clarity"),
        MotivateObj(img: "g9", titleSt: "Detox and cleanse")
    ]
    
    let reachingGoalsArra: [MotivateObj] = [
        MotivateObj(img: "r1", titleSt: "Food cravings"),
        MotivateObj(img: "r2", titleSt: "Anxious with a limited diet"),
        MotivateObj(img: "r3", titleSt: "Late-night snacking"),
        MotivateObj(img: "r4", titleSt: "Busy schedule"),
        MotivateObj(img: "r5", titleSt: "Something else"),
        MotivateObj(img: "r6", titleSt: "Unhealthy eating habits"),
        MotivateObj(img: "r7", titleSt: "Lack of support")
    ]
    
    let LikeArr: [LikeObj] = [
        LikeObj(img: "l1", titleSt: "Sedentary", detailSt: "I spend most of my day sitting"),
        LikeObj(img: "l2", titleSt: "Low Active", detailSt: "Standing work, moving throughout the day"),
        LikeObj(img: "l3", titleSt: "Active", detailSt: "My daily active most of the day"),
        LikeObj(img: "l4", titleSt: "Very Active", detailSt: "Physically active most of the day")
    ]
    
    let bitMoreArr: [bitMoreWeekends] = [
        bitMoreWeekends(img: "Layer_1 (2)", titleSt: "Yes, on Saturdays & Sundays"),
        bitMoreWeekends(img: "Layer_2", titleSt: "Yes, on Fridays, Saturdays& Sundays"),
        bitMoreWeekends(img: "Layer_2 (1)", titleSt: "Yes, on Fridays and Saturdays"),
        bitMoreWeekends(img: "Layer_1 (3)", titleSt: "No, Id rather not"),
        bitMoreWeekends(img: "Frame (2)", titleSt: "Not sure, maybe")
    ]
    
    let trackYouNutriArr: [TrackYourNutrition] = [
        TrackYourNutrition(img: "rokit", titleSt: "50 days in a row", detailSt: "Superb"),
        TrackYourNutrition(img: "l2", titleSt: "30 days in a row", detailSt: "Incredible"),
        TrackYourNutrition(img: "l3", titleSt: "14 days in a row", detailSt: "Great"),
        TrackYourNutrition(img: "l4", titleSt: "7 days in a row", detailSt: "Good")
    ]
    
    let trackYourMealArr: [TrackYourMeal] = [
        TrackYourMeal(titleSt: "Every meal", detailSt: "I plan to record everything I eat"),
        TrackYourMeal(titleSt: "Only main meals", detailSt: "I’ll track just breakfast, lunch, and dinner"),
        TrackYourMeal(titleSt: "When I remember", detailSt: "I’ll keep track sometimes, but not consistently"),
        TrackYourMeal(titleSt: "Occasionally", detailSt: "I’ll track my meals once in a while, when needed")
    ]
    
    let DietTypeArr: [DietType] = [
        DietType(img: "dt1", titleSt: "Balanced", detailSt: "Enjoy everything"),
        DietType(img: "dt2", titleSt: "Low-carb", detailSt: "Largely protein & fat, restricted carbs"),
        DietType(img: "dt3", titleSt: "Keto", detailSt: "High fat, some protein, low carb"),
        DietType(img: "dt4", titleSt: "High-protein", detailSt: "Less fat-rich foods"),
        DietType(img: "dt5", titleSt: "Low-fat", detailSt: "Protein-rich foods first"),
        DietType(img: "dt6", titleSt: "Vegetarian", detailSt: "Meat-free and fish-free food")
    ]
    
    let badEatingArr: [BadEatingObj] = [
        BadEatingObj(img: "bad1", titleSt: "I love chocolate and candy"),
        BadEatingObj(img: "bad2", titleSt: "Soda is my best friend"),
        BadEatingObj(img: "bad3", titleSt: "I consume a lot of salty food"),
        BadEatingObj(img: "bad4", titleSt: "I’m a midnight snacker"),
        BadEatingObj(img: "bad5", titleSt: "Junk food is my guilty pleasure"),
        BadEatingObj(img: "bad6", titleSt: "I eat whenever I feel bad"),
        BadEatingObj(img: "bad7", titleSt: "I tend to overeat"),
        BadEatingObj(img: "bad8", titleSt: "I wants say no to a drink"),
        BadEatingObj(img: "bad9", titleSt: "None of these above")
    ]
}
