//
//  AcheivePlanVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class AcheivePlanVC: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    var plainToAchieve = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        self.plainToAchieve = self.lbl3.text ?? ""
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
        HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view3, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
    }
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGesture() {
        [nextView, view1, view2, view3].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourUnitVC") as! YourUnitVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.plainToAchieve, forKey: DefaultKeys.shared.goal)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            case 1:
                print("👉 Lose Weight")
                self.plainToAchieve = self.lbl1.text ?? ""
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view1, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 2:
                print("👉 Maintain Current Weight")
                self.plainToAchieve = self.lbl2.text ?? ""
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view2, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 3:
                print("👉 Gain Weight")
                self.plainToAchieve = self.lbl3.text ?? ""
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view3, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    @IBAction func backBTn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
