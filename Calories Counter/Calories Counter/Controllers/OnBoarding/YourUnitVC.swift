//
//  YourUnitVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class YourUnitVC: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    var weightType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        self.weightType = self.lbl1.text ?? ""
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
        HelperFun.shared.selectView(from: [self.view1, self.view2], selectedView: self.view1, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
    }
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGesture() {
        [nextView, view1, view2].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrentWeightVC") as! CurrentWeightVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.weightType, forKey: DefaultKeys.shared.unit)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            case 1:
                print("👉 Male View tapped")
                self.weightType = self.lbl1.text ?? ""
                HelperFun.shared.selectView(from: [self.view1, self.view2], selectedView: self.view1, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 2:
                print("👉 Female View tapped")
                self.weightType = self.lbl2.text ?? ""
                HelperFun.shared.selectView(from: [self.view1, self.view2], selectedView: self.view2, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    @IBAction func backBTn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
