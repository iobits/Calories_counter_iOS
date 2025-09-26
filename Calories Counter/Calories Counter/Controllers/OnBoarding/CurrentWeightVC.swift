//
//  CurrentWeightVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class CurrentWeightVC: UIViewController {
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let weights = Array(30...200) // 30kg se 200kg tak
    let units = ["kg", "lbs"]
    
    var selectedWeight: Int = 60
    var selectedUnit: String = "kg"
    var weightStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Default selection: 60 kg
        if let index = weights.firstIndex(of: 60) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
            selectedWeight = weights[index] // ensure correct default
        }
        pickerView.selectRow(0, inComponent: 1, animated: false)
        selectedUnit = units[0]
        
        // 👇 Default value update karo
        weightStr = "\(selectedWeight) \(selectedUnit)"
        print("✅ Default Selected: \(weightStr)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextView.layer.cornerRadius = 25
    }
    
    @IBAction func backBTn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TargetWeightVC") as! TargetWeightVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.weightStr, forKey: DefaultKeys.shared.currentWeight)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

// MARK: - UIPickerView Delegate & DataSource
extension CurrentWeightVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // 1 for weight, 1 for unit
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return weights.count
        } else {
            return units.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return pickerView.frame.width * 0.7 // weight wider
        } else {
            return pickerView.frame.width * 0.3 // unit smaller
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(weights[row])"
        } else {
            return units[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedWeight = weights[row]
        } else {
            selectedUnit = units[row]
        }
        print("🔹 Selected: \(selectedWeight) \(selectedUnit)")
        self.weightStr = "\(selectedWeight) \(selectedUnit)"
    }
}
