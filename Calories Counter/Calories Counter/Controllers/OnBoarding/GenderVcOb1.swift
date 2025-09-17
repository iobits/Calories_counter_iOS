//
//  GenderVcOb1.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class GenderVcOb1: UIViewController {

    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var notPreferView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView, maleView, femaleView, notPreferView].viewsCornerRadius(25)
    }
    func tapGesture() {
        [nextView, maleView, femaleView, notPreferView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HowOldVC") as! HowOldVC
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
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
