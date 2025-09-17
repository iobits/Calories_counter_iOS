//
//  HowFastVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class HowFastVC: UIViewController {

    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var nextView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        midView.layer.cornerRadius = 10.0
        warningView.layer.cornerRadius = 10.0
        nextView.layer.cornerRadius = 25.0
    }
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourNutritionVC") as! YourNutritionVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
