//
//  ResultVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 23/09/2025.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var carbsProgress: UIProgressView!
    @IBOutlet weak var percentLabel1: UILabel!
    @IBOutlet weak var gramsLabel1: UILabel!
    
    @IBOutlet weak var proteinProgress: UIProgressView!
    @IBOutlet weak var percentLabel2: UILabel!
    @IBOutlet weak var gramsLabel2: UILabel!
    
    @IBOutlet weak var fatProgress: UIProgressView!
    @IBOutlet weak var percentLabel3: UILabel!
    @IBOutlet weak var gramsLabel3: UILabel!
    
    @IBOutlet weak var readMoreLbl: UILabel!
    @IBOutlet weak var readoreImg: UIImageView!
    
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var scanView: UIView!
    
    @IBOutlet weak var nutritionView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var resultImgView: UIImageView!
    
    
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var carbsLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var fatLbl: UILabel!
    
    private var isExpanded = false   // toggle flag
    var finalStringData = ""
    var selectedImg : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = selectedImg {
            resultImgView.image = img
        }
        
        print("final data: -", finalStringData)
        
        // Parse karke UI update karo
        let parsedData = parseFinalData(finalStringData)
        updateUI(with: parsedData)
        tapGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [saveView, scanView].viewsCornerRadius(25.0)
        [nutritionView, detailView].viewsCornerRadius(15.0)
        [carbsProgress, proteinProgress, fatProgress].viewsCornerRadius(8.0)
        resultImgView.layer.cornerRadius = resultImgView.frame.size.width/2
    }
    
    func updateUI(with data: [String: Any]) {
        dishNameLbl.text = data["dishName"] as? String
        caloriesLbl.text = "Total Calories | \(data["calories"] as? String ?? "0")"
        
        // Carbs
        if let carbsText = data["carbs"] as? String {
            carbsLbl.text = carbsText
            percentLabel1.text = extractPercentageText(from: carbsText) // ✅ alag percentage label
        }
        
        // Protein
        if let proteinText = data["protein"] as? String {
            proteinLbl.text = proteinText
            percentLabel2.text = extractPercentageText(from: proteinText)
        }
        
        // Fat
        if let fatText = data["fat"] as? String {
            fatLbl.text = fatText
            percentLabel3.text = extractPercentageText(from: fatText)
        }
        
        detailsTextView.text = cleanDetailsText(data["details"] as? String ?? "")

        
        // agar % numeric parse karte ho to progress bar set kar do
        if let carbsPct = data["carbsPct"] as? Float {
            carbsProgress.progress = carbsPct / 100.0
        }
        if let proteinPct = data["proteinPct"] as? Float {
            proteinProgress.progress = proteinPct / 100.0
        }
        if let fatPct = data["fatPct"] as? Float {
            fatProgress.progress = fatPct / 100.0
        }
    }

    func saveData(with data: [String: Any]) {

        let name = data["dishName"] as? String
        let calories = data["calories"] as? String
        let detailSt = cleanDetailsText(data["details"] as? String ?? "")
        
        let mealType = UserDefaults.standard.string(forKey: DefaultKeys.shared.mealType)
        if mealType == "breakfast"{
            let result = CoreDataManager.shared.saveBreakfast(name: name ?? "", calories: calories ?? "", date: Date(), image: selectedImg, details: detailSt)

            if result {
                print("✅ Breakfast saved successfully")
            } else {
                print("❌ Failed to save breakfast")
            }
        }else if mealType == "lunch"{
            let result = CoreDataManager.shared.saveLunch(name: name ?? "", calories: calories ?? "", date: Date(), image: selectedImg, details: detailSt)

            if result {
                print("✅ savelunch saved successfully")
            } else {
                print("❌ Failed to save savelunch")
            }
        }else if mealType == "snacks"{
            let result = CoreDataManager.shared.saveSnack(name: name ?? "", calories: calories ?? "", date: Date(), image: selectedImg, details: detailSt)

            if result {
                print("✅ saveSnack saved successfully")
            } else {
                print("❌ Failed to save saveSnack")
            }
        }else if mealType == "Dinners"{
            let result = CoreDataManager.shared.saveDinner(name: name ?? "", calories: calories ?? "", date: Date(), image: selectedImg, details: detailSt)

            if result {
                print("✅ dinner saved successfully")
            } else {
                print("❌ Failed to save dinner")
            }
        }
        
       
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewMoreBtn(_ sender: UIButton) {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            if self.isExpanded {
                self.tvHeight.constant = self.detailsTextView.contentSize.height
                self.readMoreLbl.text = "Read Less"
                self.readoreImg.image = UIImage(named: "goUp")
                
            } else {
                self.tvHeight.constant = 100
                self.readMoreLbl.text = "Read More"
                self.readoreImg.image = UIImage(named: "goldenDownArrow")
                
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func tapGesture() {
        [saveView, scanView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 saveView")
                
                let parsedData = self.parseFinalData(self.finalStringData)
                self.saveData(with: parsedData)

            case 1:
                print("scanView")
                self.dismiss(animated: true, completion: nil)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    
    private func extractPercentage(from text: String) -> Float? {
        // Example: "135 g (93%)"
        if let start = text.range(of: "("),
           let end = text.range(of: "%)") {
            let percentStr = text[start.upperBound..<end.lowerBound]
            return Float(percentStr)
        }
        return nil
    }
    
    private func extractGrams(from text: String) -> String {
        // Example: "135 g (93%)" → "135 g"
        if let range = text.range(of: "(") {
            return String(text[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
        }
        return text
    }
    
    func parseFinalData(_ text: String) -> [String: Any] {
        var result: [String: Any] = [:]
        
        // Lines ko split karo
        let lines = text.components(separatedBy: "\n")
        
        for line in lines {
            if line.lowercased().contains("dish name") {
                result["dishName"] = line.replacingOccurrences(of: "Dish Name:", with: "").trimmingCharacters(in: .whitespaces)
            } else if line.lowercased().contains("total calories") {
                result["calories"] = line.replacingOccurrences(of: "Total Calories:", with: "").trimmingCharacters(in: .whitespaces)
            } else if line.lowercased().contains("carbs:") {
                let value = line.replacingOccurrences(of: "Carbs:", with: "").trimmingCharacters(in: .whitespaces)
                result["carbs"] = value
                result["carbsPct"] = extractPercentage(from: value)
            } else if line.lowercased().contains("protein:") {
                let value = line.replacingOccurrences(of: "Protein:", with: "").trimmingCharacters(in: .whitespaces)
                result["protein"] = value
                result["proteinPct"] = extractPercentage(from: value)
            } else if line.lowercased().contains("fat:") {
                let value = line.replacingOccurrences(of: "Fat:", with: "").trimmingCharacters(in: .whitespaces)
                result["fat"] = value
                result["fatPct"] = extractPercentage(from: value)
            } else if line.lowercased().contains("details:") {
                // Details wali sari lines collect karo
                let index = lines.firstIndex(of: line) ?? 0
                let detailLines = lines[index...].dropFirst() // skip "Details:" line
                result["details"] = detailLines.joined(separator: "\n- ")
            }
        }
        
        return result
    }
    
    private func extractPercentageText(from text: String) -> String? {
        // "81 g (93%)" -> "93%"
        if let start = text.range(of: "("),
           let end = text.range(of: ")") {
            return String(text[start.upperBound..<end.lowerBound])
        }
        return nil
    }
    func cleanDetailsText(_ text: String) -> String {
        // "--" ko "-" se replace kar do
        let cleaned = text.replacingOccurrences(of: "- -", with: "-")
                          .replacingOccurrences(of: "--", with: "-")
        return cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
    }

}
