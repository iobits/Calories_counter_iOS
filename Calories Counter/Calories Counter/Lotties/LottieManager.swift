//
//  LottieManager.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//


import Foundation
import UIKit
import Lottie

//MARK: - LOTTIES PLAY FUNCTIONS
class LottieManager {
    static var animations: [UIView: LottieAnimationView] = [:]
    static func playAnimation(on view: UIView, lottieName: String, loop: LottieLoopMode = .loop) {
        // Remove previous animation if exists
        animations[view]?.removeFromSuperview()
        
        let animationView = LottieAnimationView(name: lottieName)
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loop
        animationView.play()
        
        view.addSubview(animationView)
        animations[view] = animationView
    }
    
    static func stopAnimation(on view: UIView) {
        if let animationView = animations[view] {
            animationView.stop()
        }
    }
    
    static func resumeAnimation(on view: UIView) {
        if let animationView = animations[view] {
            animationView.play()
        }
    }
    
    static func removeAnimation(from view: UIView) {
        if let animationView = animations[view] {
            animationView.removeFromSuperview()
            animations.removeValue(forKey: view)
        }
    }
}
