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

extension UIViewController {
    func showToast(message: String, duration: Double = 2.0) {
        // Create the toast label
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        // Set the label's frame and position
        let maxWidthPercentage: CGFloat = 0.8 // 80% of screen width
        let maxMessageSize = CGSize(width: self.view.frame.size.width * maxWidthPercentage, height: self.view.frame.size.height)
        let expectedSize = toastLabel.sizeThatFits(maxMessageSize)
        let labelWidth = min(maxMessageSize.width, expectedSize.width + 20)
        let labelHeight = min(maxMessageSize.height, expectedSize.height + 10)
        
        toastLabel.frame = CGRect(x: (self.view.frame.size.width - labelWidth) / 2,
                                  y: self.view.frame.size.height - 100,
                                  width: labelWidth,
                                  height: labelHeight)
        
        // Add the label to the view
        self.view.addSubview(toastLabel)
        
        // Animate the toast message
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}



extension UIViewController {
    func showAlert(title: String, message: String, okHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okHandler?()   // 👉 jab OK click hoga to yeh closure call hoga
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
