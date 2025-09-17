//
//  Extension.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

extension Array where Element: UIView {
    
    func addTapGesture(action: @escaping (Int, UIView) -> Void) {
        for (index, view) in self.enumerated() {
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(
                target: ViewTapHandler.shared,
                action: #selector(ViewTapHandler.shared.handleTap(_:))
            )
            view.addGestureRecognizer(tap)
            ViewTapHandler.shared.actions[view] = { tappedView in
                action(index, tappedView)
            }
        }
    }
}


private class ViewTapHandler {
    static let shared = ViewTapHandler()
    var actions: [UIView: (UIView) -> Void] = [:]
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, let action = actions[view] {
            action(view)
        }
    }
}


extension Array where Element: UIView {
    func viewsCornerRadius(_ radius: CGFloat) {
        for view in self {
            view.layer.cornerRadius = radius
            view.clipsToBounds = true
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        guard cString.count == 6 else {
            self.init(white: 0.0, alpha: 1.0) // default black agar hex galat ho
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

