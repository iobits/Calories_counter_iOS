//
//  SplashVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestures()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextView.layer.cornerRadius = 25
    }
    
    func tapGestures(){
        [nextView].addTapGesture { index, tappedView in
            print("👉 View index: \(index)")
            print("👉 Ye view tap hua: \(tappedView)")
            self.navigation()
        }
    }
    func navigation(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "GenderVcOb1") as! GenderVcOb1
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
