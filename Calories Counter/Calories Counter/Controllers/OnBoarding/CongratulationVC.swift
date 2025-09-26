//
//  CongratulationVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 25/09/2025.
//

import UIKit

class CongratulationVC: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var pro1: UIProgressView!
    @IBOutlet weak var pro2: UIProgressView!
    @IBOutlet weak var pro3: UIProgressView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var getStartView: UIView!
    
    @IBOutlet weak var crabsGramLbl: UILabel!
    @IBOutlet weak var proteinGramLbl: UILabel!
    @IBOutlet weak var fatsGramLbl: UILabel!
    
    @IBOutlet weak var carbsPerctageLbl: UILabel!
    @IBOutlet weak var proteinPerctageLbl: UILabel!
    @IBOutlet weak var fatPerctageLbl: UILabel!
    
    @IBOutlet weak var dailyCaloriesLbl: UILabel!
    @IBOutlet weak var yourGoalWeigtLbl: UILabel!
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [view1, view2].viewsCornerRadius(15)
        [getStartView].viewsCornerRadius(25.0)
        [pro1, pro2, pro3].viewsCornerRadius(8.0)
        fetchDataFromGemni(result: result)
        
    }
    
    func fetchDataFromGemni(result: String){
        // MARK: - Carbs
        if let carbs = result.extractValue(for: "Carbs") {
            let parts = carbs.split(separator: " ")
            if parts.count >= 3 {
                self.crabsGramLbl.text = "\(parts[0]) \(parts[1])"   // e.g. "185 g"
                self.carbsPerctageLbl.text = parts[2].replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")         // e.g. "40%"
                
                if let percentage = Int(parts[2].replacingOccurrences(
                    of: "[^0-9]", with: "", options: .regularExpression)) {
                    self.pro1.progress = Float(percentage) / 100.0   // 0.40
                }
            }
        }
        
        // MARK: - Protein
        if let protein = result.extractValue(for: "Protein") {
            let parts = protein.split(separator: " ")
            if parts.count >= 3 {
                self.proteinGramLbl.text = "\(parts[0]) \(parts[1])"
                self.proteinPerctageLbl.text = parts[2].replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                
                if let percentage = Int(parts[2].replacingOccurrences(
                    of: "[^0-9]", with: "", options: .regularExpression)) {
                    self.pro2.progress = Float(percentage) / 100.0
                }
            }
        }
        
        // MARK: - Fat
        if let fat = result.extractValue(for: "Fat") {
            let parts = fat.split(separator: " ")
            if parts.count >= 3 {
                self.fatsGramLbl.text = "\(parts[0]) \(parts[1])"
                self.fatPerctageLbl.text = parts[2].replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                
                if let percentage = Int(parts[2].replacingOccurrences(
                    of: "[^0-9]", with: "", options: .regularExpression)) {
                    self.pro3.progress = Float(percentage) / 100.0
                }
            }
        }
        
        // MARK: - Calories
        if let calories = result.extractValue(for: "Daily Calorie Goal") {
            // Sirf digits nikal lo
            let numberOnly = calories.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            self.dailyCaloriesLbl.text = numberOnly // e.g. "2450"
        }
        
        
        // MARK: - Goal Weight
        if let goalWeight = result.extractValue(for: "Goal Weight") {
            self.yourGoalWeigtLbl.text = goalWeight // "60 kg by February 12, 2025"
        }
        
    }
    
    
    
    @IBAction func goNextBtn(_ sender: UIButton) {
        let tabBarVC = CustomTabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
}

extension String {
    func extractValue(for key: String) -> String? {
        if let range = self.range(of: "\(key):") {
            let substring = self[range.upperBound...]
            let line = substring.split(separator: "\n").first ?? ""
            return line.trimmingCharacters(in: .whitespaces)
        }
        return nil
    }
}
