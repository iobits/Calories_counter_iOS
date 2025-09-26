//
//  ProgressVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 25/09/2025.
//

import UIKit

class ProgressVC: UIViewController {
    
    @IBOutlet weak var progresView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.playAnimation(on: progresView, lottieName: Lotties_Constant.shared.wait)
        fetchDataFromGemni()
    }
    
    func fetchDataFromGemni(){
        let loaded = FullUserHealthData.load()
        print("👉 Loaded:", loaded.gender, loaded.goal)
        
        HealthPlanAI().generateHealthPlan(for: loaded) { result in
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CongratulationVC") as! CongratulationVC
                vc.modalPresentationStyle = .fullScreen
                vc.result = result ?? ""
                self.present(vc, animated: false)
            }
           
        }
    }
    
    
}
