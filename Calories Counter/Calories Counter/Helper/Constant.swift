//
//  Extension.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

struct MotivateObj {
    var img: String
    var titleSt: String
}

struct LikeObj {
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
}
