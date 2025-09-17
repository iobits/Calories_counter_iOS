//
//  HomeViewModel.swift
//  Calories Counter
//
//  Created by Mac Mini on 17/09/2025.
//


import Foundation

class HomeViewModel {
    
    private let calendar = Calendar.current
    private(set) var currentDate = Date()
    private(set) var days: [DayModel] = []
    
    // Callback to notify VC when data changes
    var onDaysUpdated: (() -> Void)?
    var onMonthUpdated: ((String) -> Void)?
    
    func generateDays(for date: Date = Date()) {
        days.removeAll()
        currentDate = date
        
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return }
        let today = Date()
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        let monthName = monthFormatter.string(from: date)
        onMonthUpdated?(monthName) // ✅ update VC label
        
        for day in range {
            var components = calendar.dateComponents([.year, .month], from: date)
            components.day = day
            guard let fullDate = calendar.date(from: components) else { continue }
            
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "E"
            let dayString = String(dayFormatter.string(from: fullDate).prefix(1))
            
            let isToday = calendar.isDate(fullDate, inSameDayAs: today)
            
            days.append(DayModel(day: dayString,
                                 date: day,
                                 isSelected: isToday,
                                 isToday: isToday))
        }
        
        onDaysUpdated?()
    }
    
    func selectDay(at index: Int) {
        for i in 0..<days.count {
            days[i].isSelected = (i == index)
        }
        onDaysUpdated?()
    }
    
    func getMonthsList() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        return (1...12).compactMap { month -> String? in
            var comp = calendar.dateComponents([.year], from: currentDate)
            comp.month = month
            guard let date = calendar.date(from: comp) else { return nil }
            return formatter.string(from: date)
        }
    }
    
    func updateMonth(to monthIndex: Int) {
        var comp = calendar.dateComponents([.year], from: currentDate)
        comp.month = monthIndex + 1
        if let date = calendar.date(from: comp) {
            generateDays(for: date)
        }
    }
}
