//
//  FastingSchedualVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 18/09/2025.
//

import UIKit

class FastingSchedualVC: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet weak var nextView: UIView!
    
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let meridian = ["AM", "PM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.dataSource = self
        datePickerView.delegate = self
        tapGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [view1, view2].viewsCornerRadius(15)
        [nextView].viewsCornerRadius(25)
    }
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LastbiteVC") as! LastbiteVC
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: false)
        
            default:
                print("Unknown View tapped")
            }
        }
    }
}
extension FastingSchedualVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hours.count
        case 1: return minutes.count
        case 2: return meridian.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0: return 60 // Hour
        case 1: return 60 // Minute
        case 2: return 50 // AM/PM
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        switch component {
        case 0:
            label.text = "\(hours[row])"
        case 1:
            label.text = String(format: "%02d", minutes[row])
        case 2:
            label.text = meridian[row]
        default:
            label.text = ""
        }
        
        return label
    }
}
