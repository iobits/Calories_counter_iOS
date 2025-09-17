//
//  Structures.swift
//  Calories Counter
//
//  Created by Mac Mini on 17/09/2025.
//

import Foundation

struct DayModel {
    let day: String   // S, M, T, W ...
    let date: Int     // 1, 2, 3 ...
    var isSelected: Bool
    let isToday: Bool
}
