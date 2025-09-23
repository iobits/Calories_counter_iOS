//
//  ResultVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 23/09/2025.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var percentLabel1: UILabel!
    @IBOutlet weak var gramsLabel1: UILabel!
    
    
    @IBOutlet weak var progress2: UIProgressView!
    @IBOutlet weak var percentLabel2: UILabel!
    @IBOutlet weak var gramsLabel2: UILabel!
    
    @IBOutlet weak var progress3: UIProgressView!
    @IBOutlet weak var percentLabel3: UILabel!
    @IBOutlet weak var gramsLabel3: UILabel!
    
    @IBOutlet weak var readMoreLbl: UILabel!
    @IBOutlet weak var readoreImg: UIImageView!
    
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var scanView: UIView!
    
    
    @IBOutlet weak var nutritionView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    private var isExpanded = false   // toggle flag
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgress()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [saveView, scanView].viewsCornerRadius(25.0)
        [nutritionView, detailView].viewsCornerRadius(15.0)
    }
    
    @IBAction func viewMoreBtn(_ sender: UIButton) {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            if self.isExpanded {
                self.tvHeight.constant = self.textView.contentSize.height
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
                
            case 1:
                print("scanView")
                self.dismiss(animated: true, completion: nil)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    func setupProgress() {
        // Example data (replace with your actual data)
        let carbs: Float = 109     // g
        let carbsTarget: Float = 198
        let fat: Float = 130.5     // g
        let fatTarget: Float = 52
        let protein: Float = 60    // g (dummy value, you can replace with real)
        let proteinTarget: Float = 100
        
        // --- Calories ---
        let carbsKcal = carbs * 4
        let fatKcal = fat * 9
        let proteinKcal = protein * 4
        let totalKcal = carbsKcal + fatKcal + proteinKcal
        
        // --- Carbs ---
        let carbsPercent = carbsKcal / totalKcal
        progress1.progress = carbs / carbsTarget   // bar shows progress vs target
        progress1.progressTintColor = UIColor(hex: "#AEA1EF")
        progress1.trackTintColor = UIColor(hex: "#AEA1EF").withAlphaComponent(0.2)
        progress1.layer.cornerRadius = 4
        progress1.clipsToBounds = true
        percentLabel1.text = "\(Int(carbsPercent * 100))%"      // "55%"
        gramsLabel1.text = "\(carbs) / \(carbsTarget) g"
        
        // --- Fat ---
        let fatPercent = fatKcal / totalKcal
        progress2.progress = fat / fatTarget
        progress2.progressTintColor = UIColor(hex: "#F8C59D")
        progress2.trackTintColor = UIColor(hex: "#F8C59D").withAlphaComponent(0.2)
        progress2.layer.cornerRadius = 4
        progress2.clipsToBounds = true
        percentLabel2.text = "\(Int(fatPercent * 100))%"        // "26%"
        gramsLabel2.text = "\(fat) / \(fatTarget) g"
        
        // --- Protein (ya dusra Fat row jaisa screenshot me) ---
        let proteinPercent = proteinKcal / totalKcal
        progress3.progress = protein / proteinTarget
        progress3.progressTintColor = UIColor(hex: "#F3939B")
        progress3.trackTintColor = UIColor(hex: "#F3939B").withAlphaComponent(0.2)
        progress3.layer.cornerRadius = 4
        progress3.clipsToBounds = true
        percentLabel3.text = "\(Int(proteinPercent * 100))%"    // e.g. "28%"
        gramsLabel3.text = "\(protein) / \(proteinTarget) g"
    }
}
