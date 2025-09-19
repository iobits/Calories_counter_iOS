//
//  FastingHomeVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class FastingHomeVC: UIViewController {
    
    @IBOutlet weak var timeView: UIView!
    
    
    @IBOutlet weak var startFastView: UIView!
    private var circularTimer: CircularTimerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add CircularTimerView inside timeView
        circularTimer = CircularTimerView(frame: timeView.bounds)
        circularTimer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timeView.addSubview(circularTimer)
        
        // Start with 1 minute
        circularTimer.startTimer(totalSeconds: 300)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [startFastView].viewsCornerRadius(20.0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let dialog = BottomCardView()
//        dialog.configure(
//            image: UIImage(named: "thumb"),   // 👈 yahan aap apni custom image doge
//            title: "Evening is the best time to start fasting",
//            subtitle: "The easiest way is to follow a certain structure by skipping one main meal (usually breakfast or dinner) and mostly fasting overnight, which reduces the feeling of hunger.",
//            primaryText: "Got it",
//            secondaryText: nil, // hide if nil
//            primaryAction: {
//                print("Got it tapped")
//                dialog.dismiss()
//            }
//        )
//        dialog.present(in: view)
        showLastMealDialog()
    }
    
    private func showLastMealDialog() {
         let card = BottomCardView()
         card.configure(
             image: UIImage(named: "thumb"), // apni custom image
             title: "End this fast?",
             subtitle: "If the interval between meals is less than 9 hours, it’s not considered as fasting and won’t appear in your history",
             primaryText: "Continue Fast",
             secondaryText: "Cancel this Fast",
             primaryAction: { [weak card] in
                 card?.dismiss()
                 print("✅ Today at 11:22 tapped")
             },
             secondaryAction: { [weak card] in
                 card?.dismiss()
                 print("✅ Another Time tapped")
             }
         )
         card.present(in: view)
     }
}
