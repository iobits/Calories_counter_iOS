//
//  AddWaterVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 22/09/2025.
//

import UIKit

class AddWaterVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var cancelView: UIView!
    
    let tabBarVC = CustomTabBarController()
    let waterValues = Array(stride(from: 50, through: 500, by: 50)) // 50ml step
    let meridian = ["ml"]
    var callback : ((Bool) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
        datePickerView.selectRow(waterValues.count/2, inComponent: 0, animated: false) // Default center
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [saveView, cancelView].viewsCornerRadius(25.0)
        [mainView].viewsCornerRadius(20.0)
    }
    
    func tapGesture() {
        [saveView, cancelView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 save view")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityTrackerVC") as! ActivityTrackerVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case 1:
                print("cancel")
                self.callback?(true)
                self.dismiss(animated: true, completion: nil)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

extension AddWaterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return waterValues.count
        case 1: return meridian.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0: return 60 // Hour
        case 1: return 50
        default: return 0
        }
    }
    
    // Custom view for each row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        switch component {
        case 0:
            label.text = "\(waterValues[row])"
        case 1:
            label.text = String(meridian[row])
        default:
            label.text = ""
        }
        
        return label
    }
    
    // Highlight selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    
    // Apply styles dynamically
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let selectedRow = pickerView.selectedRow(inComponent: component)
        let value = "\(waterValues[row])"
        
        if row == selectedRow {
            // Selected row -> bold + black
            return NSAttributedString(string: value, attributes: [ .font: UIFont.boldSystemFont(ofSize: 28), .foregroundColor: UIColor.black ])
        } else {
            // Other rows -> light gray
            return NSAttributedString(string: value, attributes: [ .font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.lightGray])
        }
    }
}
