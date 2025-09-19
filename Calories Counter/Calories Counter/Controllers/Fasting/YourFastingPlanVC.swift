//
//  YourFastingPlanVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 18/09/2025.
//

import UIKit

class YourFastingPlanVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var recomndView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HelperFun.shared.selectView(from: [view1, view2, view3, view4], selectedView: view1, selectedHexColor: "#FFFACD")
        [nextView].viewsCornerRadius(25)
        recomndView.layer.cornerRadius = 15.0
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGesture() {
        [nextView, view1, view2, view3, view4].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FastingSchedualVC") as! FastingSchedualVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case 1:
                print("👉 View 1 tapped")
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3, self.view4], selectedView: self.view1, selectedHexColor: "#FFFACD")
            case 2:
                print("👉 View 2 tapped")
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3, self.view4], selectedView: self.view2, selectedHexColor: "#FFFACD")
            case 3:
                print("👉 View 3 tapped")
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3, self.view4], selectedView: self.view3, selectedHexColor: "#FFFACD")
            case 4:
                print("👉 View 4 tapped")
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3, self.view4], selectedView: self.view4, selectedHexColor: "#FFFACD")
            default:
                print("Unknown View tapped")
            }
        }
    }
}
