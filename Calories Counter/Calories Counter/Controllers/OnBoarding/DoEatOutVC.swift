//
//  DoEatOutVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class DoEatOutVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    var eatOutStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        eatOutStr = "Sometimes"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
        HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view2, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func tapGesture() {
        [nextView, view1, view2, view3].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalzNotificationVC") as! CalzNotificationVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.eatOutStr, forKey: DefaultKeys.shared.eatOut)
                UserDefaults.standard.synchronize()
              
                self.present(vc, animated: false)
            case 1:
                self.eatOutStr = "Only at home"
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view1, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 2:
                self.eatOutStr = "Sometimes"
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view2, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 3:
                self.eatOutStr = "Often"
                HelperFun.shared.selectView(from: [self.view1, self.view2, self.view3], selectedView: self.view3, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
