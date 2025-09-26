//
//  YourHeightVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class YourHeightVC: UIViewController {
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    let heights = Array(100...250) // 100cm se 250cm tak
    let units = ["cm", "Feet", "Inches"]
    
    var selectedHeight: Int = 180
    var selectedUnit: String = "cm"
    var heightStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Default selection -> 180 cm
        if let index = heights.firstIndex(of: 180) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
            selectedHeight = heights[index] // assign default height
        }
        pickerView.selectRow(0, inComponent: 1, animated: false)
        selectedUnit = units[0] // assign default unit
        
        // 🔹 Assign heightStr and healthData when controller loads
        heightStr = "\(selectedHeight) \(selectedUnit)"
        UserDefaults.standard.set(self.heightStr, forKey: DefaultKeys.shared.height)
        UserDefaults.standard.synchronize()
        print("✅ Default Height: \(heightStr)")
        tapGesture()
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourGoalsVC") as! YourGoalsVC
                vc.modalPresentationStyle = .fullScreen
                
                UserDefaults.standard.set(self.heightStr, forKey: DefaultKeys.shared.height)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

// MARK: - UIPickerView Delegate & DataSource
extension YourHeightVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // 1 for height values, 1 for unit
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return heights.count
        } else {
            return units.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return pickerView.frame.width * 0.7
        } else {
            return pickerView.frame.width * 0.3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(heights[row])"
        } else {
            return units[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedHeight = heights[row]
        } else {
            selectedUnit = units[row]
        }
        print("📏 Selected Height: \(selectedHeight) \(selectedUnit)")
        heightStr = "\(selectedHeight) \(selectedUnit)"
    }
}
