//
//  Extension.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class HelperFun: NSObject{
    static let shared = HelperFun()
    func makeCircular(views: [UIView]) {
        for v in views {
            v.layoutIfNeeded()
            v.layer.cornerRadius = v.frame.size.width / 2
            v.layer.masksToBounds = true
        }
    }
    
    func selectView(
        from views: [UIView],
        selectedView: UIView,
        selectedHexColor: String,
        cornerRadius: CGFloat = 12 // default 12, but can be customized
    ) {
        for view in views {
            if view == selectedView {
                view.layer.borderWidth = 2
                view.layer.borderColor = UIColor.systemYellow.cgColor
                view.layer.cornerRadius = cornerRadius
                view.layer.masksToBounds = true
                view.backgroundColor = UIColor(hex: selectedHexColor)
            } else {
                view.layer.borderWidth = 0
                view.layer.borderColor = nil
                view.layer.cornerRadius = cornerRadius
                view.backgroundColor = .white
            }
        }
    }
    
    
}
