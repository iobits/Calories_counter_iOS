//
//  ProfileVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 17/09/2025.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var personlaDataView: UIView!
    @IBOutlet weak var healthDataView: UIView!
    @IBOutlet weak var appSettingView: UIView!
    @IBOutlet weak var otherView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HelperFun.shared.makeCircular(views: [profileView])
        [personlaDataView, healthDataView, appSettingView, otherView].viewsCornerRadius(15)
    }
    
    @IBAction func backBTn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
