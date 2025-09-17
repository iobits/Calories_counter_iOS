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
    
}
