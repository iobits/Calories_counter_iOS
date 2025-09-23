//
//  WalkingVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 22/09/2025.
//

import UIKit

class WalkingVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var cancelView: UIView!
    
    let hours = Array(0...23)   // 0–23 hrs
    let minutes = stride(from: 0, through: 55, by: 5).map { $0 } // 0,5,10,...55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
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
                print("👉 save view")
                DispatchQueue.main.async {
                    let tabBarVC = CustomTabBarController()
                    tabBarVC.selectedIndex = 3
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.rootViewController = tabBarVC
                        window.makeKeyAndVisible()
                    }
                }

                
            case 1:
                print("cancel")
                self.dismiss(animated: true, completion: nil)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

    // MARK: - PickerView DataSource & Delegate
extension WalkingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4 // Hours | "hrs" | Minutes | "min"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hours.count
        case 1: return 1   // "hrs"
        case 2: return minutes.count
        case 3: return 1   // "min"
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0: return 60   // hours
        case 1: return 50   // "hrs"
        case 2: return 60   // minutes
        case 3: return 50   // "min"
        default: return 50
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    // ✅ Sirf attributedTitle use karna hai
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let text: String
        let attributes: [NSAttributedString.Key: Any]

        switch component {
        case 0: // Hours number
            text = "\(hours[row])"
            attributes = [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.black
            ]
        case 1: // "hrs"
            text = "hrs"
            attributes = [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular), // ✅ chota font
                .foregroundColor: UIColor.darkGray
            ]
        case 2: // Minutes number
            text = String(format: "%02d", minutes[row])
            attributes = [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.black
            ]
        case 3: // "min"
            text = "m"
            attributes = [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular), // ✅ chota font
                .foregroundColor: UIColor.darkGray
            ]
        default:
            text = ""
            attributes = [:]
        }

        return NSAttributedString(string: text, attributes: attributes)
    }

}
