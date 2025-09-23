//
//  FirstLastMealVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class FirstLastMealVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView, view1, view2].viewsCornerRadius(25)
    }
    func tapGesture() {
        [nextView, view1, view2].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoEatOutVC") as! DoEatOutVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case 1:
                HelperFun.shared.selectView(from: [self.view1, self.view2], selectedView: self.view1, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 2:
                HelperFun.shared.selectView(from: [self.view1, self.view2], selectedView: self.view2, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
