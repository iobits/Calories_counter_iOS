//
//  CalzNotificationVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class CalzNotificationVC: UIViewController {

    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.layer.cornerRadius = 10.0
        notificationView.layer.cornerRadius = 25.0
    }
    func tapGesture() {
        [notificationView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnWeekendVC") as! OnWeekendVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
