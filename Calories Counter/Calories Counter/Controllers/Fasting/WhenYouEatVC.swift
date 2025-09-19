//
//  WhenYouEatVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 18/09/2025.
//

import UIKit

class WhenYouEatVC: UIViewController {
 
    @IBOutlet weak var nextView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestures()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
    }
    
    func tapGestures(){
        [nextView].addTapGesture { index, tappedView in
            print("👉 View index: \(index)")
            print("👉 Ye view tap hua: \(tappedView)")
            self.navigation()
        }
    }
    func navigation(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "FastingJourneyVC") as! FastingJourneyVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
