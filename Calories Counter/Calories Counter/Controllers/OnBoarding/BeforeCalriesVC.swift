//
//  BeforeCalriesVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class BeforeCalriesVC: UIViewController {

    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var nextView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView, view1, view2, view3].viewsCornerRadius(25)
    }
    func tapGesture() {
        [nextView, view1, view2, view3].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AcheivePlanVC") as! AcheivePlanVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case 1:
                print("👉 Male View tapped")
            case 2:
                print("👉 Female View tapped")
            case 3:
                print("👉 Not Prefer View tapped")
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    @IBAction func backBTn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
