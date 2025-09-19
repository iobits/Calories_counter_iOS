//
//  FastingJourneyVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 18/09/2025.
//

import UIKit

class FastingJourneyVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var tipsView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestures()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
        [view1, view2, tipsView].viewsCornerRadius(15)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGestures(){
        [nextView].addTapGesture { index, tappedView in
            print("👉 View index: \(index)")
            print("👉 Ye view tap hua: \(tappedView)")
            self.navigation()
        }
    }
    func navigation(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "YourFastingPlanVC") as! YourFastingPlanVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
