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

    var genderType = "Male"
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
        HelperFun.shared.selectView(from: [self.maleView, self.femaleView, self.notPreferView], selectedView: self.maleView, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
    }
    func tapGesture() {
        [nextView, maleView, femaleView, notPreferView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                self.nextVc()
            case 1:
                print("👉 Male View tapped")
                self.genderType = "Male"
                HelperFun.shared.selectView(from: [self.maleView, self.femaleView, self.notPreferView], selectedView: self.maleView, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 2:
                print("👉 Female View tapped")
                self.genderType = "Female"
                HelperFun.shared.selectView(from: [self.maleView, self.femaleView, self.notPreferView], selectedView: self.femaleView, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            case 3:
                print("👉 Not Prefer View tapped")
                self.genderType = "Not Prefer"
                HelperFun.shared.selectView(from: [self.maleView, self.femaleView, self.notPreferView], selectedView: self.notPreferView, selectedHexColor: "#FFE98B", cornerRadius: 25.0)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func nextVc() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HowOldVC") as! HowOldVC
        vc.modalPresentationStyle = .fullScreen
        UserDefaults.standard.set(genderType, forKey: DefaultKeys.shared.gender)
        UserDefaults.standard.synchronize()
        self.present(vc, animated: false)
    }

}
