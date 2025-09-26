//
//  HowOldVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class HowOldVC: UIViewController {
    
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet weak var nextView: UIView!
    
    let months = Calendar.current.monthSymbols // ["January", "February", ...]
    let days = Array(1...31)
    let years = Array((1900...Calendar.current.component(.year, from: Date())).reversed()) // Proper array
    var dateSt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
        
        // Default selection: July 31 2003
        if let monthIndex = months.firstIndex(of: "July") {
            datePickerView.selectRow(monthIndex, inComponent: 0, animated: false)
        }
        datePickerView.selectRow(30, inComponent: 1, animated: false) // 31
        datePickerView.selectRow(years.firstIndex(of: 2003) ?? 0, inComponent: 2, animated: false)
        
        // 👇 Get default selected values immediately
        let month = months[datePickerView.selectedRow(inComponent: 0)]
        let day = days[datePickerView.selectedRow(inComponent: 1)]
        let year = years[datePickerView.selectedRow(inComponent: 2)]
        dateSt = "\(month) \(day) \(year)"
        print("👉 Default Selected: \(dateSt)")
        
        tapGesture()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeforeCalriesVC") as! BeforeCalriesVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.dateSt, forKey: DefaultKeys.shared.birthDate)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
    
}
extension HowOldVC: UIPickerViewDelegate, UIPickerViewDataSource{
    // MARK: - Picker DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // Month, Day, Year
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return months.count
        case 1: return days.count
        case 2: return years.count
        default: return 0
        }
    }
    
    // MARK: - Picker Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return months[row]
        case 1: return "\(days[row])"
        case 2: return "\(years[row])"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = months[datePickerView.selectedRow(inComponent: 0)]
        let day = days[datePickerView.selectedRow(inComponent: 1)]
        let year = years[datePickerView.selectedRow(inComponent: 2)]
        
        print("👉 Selected: \(month) \(day) \(year)")
        dateSt = "\(month) \(day) \(year)"
    }
}
