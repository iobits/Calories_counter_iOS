//
//  MealADayVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class MealADayVC: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nextView: UIView!
    
    // Picker values
    let meals = ["1", "2", "3", "4", "5"]
    // Selected value
    var selectedMeal: String = "1"
    var mealInADaySt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Default selection -> 3 meals
        if let index = meals.firstIndex(of: "3") {
            pickerView.selectRow(index, inComponent: 0, animated: false)
            selectedMeal = meals[index]
        }
        tapGesture()
        mealInADaySt = meals[2]
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InterFastingVC") as! InterFastingVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.mealInADaySt, forKey: DefaultKeys.shared.mealInADay)
                UserDefaults.standard.synchronize()
                
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

   // MARK: - UIPickerView Delegate & DataSource
   extension MealADayVC: UIPickerViewDelegate, UIPickerViewDataSource {
       
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1 // sirf ek column for meals
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return meals.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return meals[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           selectedMeal = meals[row]
           print("🍽 Selected Meals: \(selectedMeal)")
           mealInADaySt = selectedMeal
       }
   }
