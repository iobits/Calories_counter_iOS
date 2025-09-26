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
    
    func viewsConerRadius(for views: [UIView], radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 1.0) {
        for view in views {
            view.layer.cornerRadius = radius
            view.clipsToBounds = true
            
            if let color = borderColor {
                view.layer.borderColor = color.cgColor
                view.layer.borderWidth = borderWidth
            }
        }
    }
    func adsCornerradius(for views: [UIView], radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 1.0) {
        for view in views {
            view.layer.cornerRadius = radius
            view.clipsToBounds = true
            
            if let color = borderColor {
                view.layer.borderColor = color.cgColor
                view.layer.borderWidth = borderWidth
            }
        }
    }
    
    // Preprocess image: resize for better detection
    func preprocessImage(_ image: UIImage) -> UIImage {
        let targetSize = CGSize(width: 640, height: 640)
        UIGraphicsBeginImageContext(targetSize)
        image.draw(in: CGRect(origin: .zero, size: targetSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? image
    }
}
