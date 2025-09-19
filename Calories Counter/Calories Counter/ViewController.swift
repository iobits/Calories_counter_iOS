//
//  ViewController.swift
//  Calories Counter
//
//  Created by Mac Mini on 04/08/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var camView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottieManager.playAnimation(on: camView, lottieName: Lotties_Constant.shared.cam)
        LottieManager.playAnimation(on: loadingView, lottieName: Lotties_Constant.shared.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            
            // Example: 2 sec delay then go to TabBar
            let tabBarVC = CustomTabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true, completion: nil)

            
            
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: false)
        })
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

