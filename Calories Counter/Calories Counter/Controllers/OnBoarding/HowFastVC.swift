//
//  HowFastVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class HowFastVC: UIViewController {
    
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rateLabel: UILabel!      // e.g. "Optimal"
    @IBOutlet weak var valueLabel: UILabel!     // e.g. "0.5 kg"
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        
        setupSlider()
        updateLabels(for: slider.value) // initial update
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        midView.layer.cornerRadius = 10.0
        warningView.layer.cornerRadius = 10.0
        nextView.layer.cornerRadius = 25.0
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourNutritionVC") as! YourNutritionVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set("\(self.valueLabel.text ?? "") per Week", forKey: DefaultKeys.shared.goalSpeed)
                UserDefaults.standard.synchronize()
               
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
    private func setupSlider() {
        slider.minimumValue = 0.1   // 0.1 kg per week
        slider.maximumValue = 1.0   // 1.0 kg per week
        slider.value = 0.5          // default value
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    }
    @objc private func sliderChanged(_ sender: UISlider) {
        updateLabels(for: sender.value)
    }
    
    private func updateLabels(for value: Float) {
        // Round to 1 decimal place
        let rounded = round(value * 10) / 10.0
        valueLabel.text = "\(rounded) kg"
        
        switch rounded {
        case 0.1...0.3:
            rateLabel.text = "Slow"
            rateLabel.textColor = .orange
        case 0.4...0.6:
            rateLabel.text = "Optimal"
            rateLabel.textColor = .systemGreen
        default:
            rateLabel.text = "Fast"
            rateLabel.textColor = .red
        }
    }
}
