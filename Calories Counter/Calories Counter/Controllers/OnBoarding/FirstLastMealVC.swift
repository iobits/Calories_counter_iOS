//
//  FirstLastMealVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class FirstLastMealVC: UIViewController {
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var firstTimeLbl: UILabel!
    @IBOutlet weak var secondTimelbl: UILabel!
    
    private var firstMealTime: Date?
    private var lastMealTime: Date?
    var mealTimingStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        addLabelTapGestures()
        // 🔹 Default Times
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        if let defaultFirst = formatter.date(from: "09:00 AM"),
           let defaultLast = formatter.date(from: "07:00 PM") {
            
            self.firstMealTime = defaultFirst
            self.lastMealTime = defaultLast
            
            self.firstTimeLbl.text = formatter.string(from: defaultFirst)
            self.secondTimelbl.text = formatter.string(from: defaultLast)
            
            // Default mealTimingStr
            self.mealTimingStr = "First Meal: \(formatter.string(from: defaultFirst)), Last Meal: \(formatter.string(from: defaultLast))"
            UserDefaults.standard.set(self.mealTimingStr, forKey: DefaultKeys.shared.mealTiming)
            UserDefaults.standard.synchronize()
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [nextView].viewsCornerRadius(25)
        HelperFun.shared.selectView(from: [self.view1, self.view2],
                                    selectedView: self.view1,
                                    selectedHexColor: "#FFE98B",
                                    cornerRadius: 25.0)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func tapGesture() {
        [nextView, view1, view2].addTapGesture { index, tappedView in
            switch index {
            case 0:
                // 👉 Next button tapped
                    guard let first = self.firstMealTime, let last = self.lastMealTime else {
                        print("⚠️ Please select both times before continuing.")
                        return
                    }
                    let formatter = DateFormatter()
                    formatter.timeStyle = .short

                    let firstStr = formatter.string(from: first)
                    let lastStr = formatter.string(from: last)
                    
                    // 🔹 MealTiming String banayi
                    self.mealTimingStr = "First Meal: \(firstStr), Last Meal: \(lastStr)"
                    
                    // 🔹 HealthData me set kiya
                UserDefaults.standard.set(self.mealTimingStr, forKey: DefaultKeys.shared.mealTiming)
                UserDefaults.standard.synchronize()
                    
                    print("🍽 Meal Timing Saved: \(self.mealTimingStr)")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoEatOutVC") as! DoEatOutVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                
            case 1:
                // View1 highlight only
                HelperFun.shared.selectView(from: [self.view1, self.view2],
                                            selectedView: self.view1,
                                            selectedHexColor: "#FFE98B",
                                            cornerRadius: 25.0)
                
            case 2:
                // View2 highlight only
                HelperFun.shared.selectView(from: [self.view1, self.view2],
                                            selectedView: self.view2,
                                            selectedHexColor: "#FFE98B",
                                            cornerRadius: 25.0)
                
            default:
                break
            }
        }
    }
    
    private func addLabelTapGestures() {
        let firstTap = UITapGestureRecognizer(target: self, action: #selector(firstTimeTapped))
        firstTimeLbl.isUserInteractionEnabled = true
        firstTimeLbl.addGestureRecognizer(firstTap)
        
        let secondTap = UITapGestureRecognizer(target: self, action: #selector(secondTimeTapped))
        secondTimelbl.isUserInteractionEnabled = true
        secondTimelbl.addGestureRecognizer(secondTap)
    }
    
    @objc private func firstTimeTapped() {
        showTimePicker { date in
            self.firstMealTime = date
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            self.firstTimeLbl.text = formatter.string(from: date)
        }
    }
    
    @objc private func secondTimeTapped() {
        showTimePicker { date in
            self.lastMealTime = date
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            self.secondTimelbl.text = formatter.string(from: date)
        }
    }
    
    private func showTimePicker(completion: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "Select Time", message: nil, preferredStyle: .actionSheet)
        
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.frame = CGRect(x: 0, y: 0, width: alert.view.bounds.width, height: 200)
        
        alert.view.addSubview(picker)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            completion(picker.date)
        }))
        
        alert.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
}
