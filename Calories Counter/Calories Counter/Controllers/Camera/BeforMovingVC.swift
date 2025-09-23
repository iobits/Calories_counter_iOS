//
//  BeforMovingVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 22/09/2025.
//

import UIKit

class BeforMovingVC: UIViewController {

    @IBOutlet weak var mainVIew: UIView!
    
    
    @IBOutlet weak var startFast: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainVIew.layer.cornerRadius = 20.0
        startFast.layer.cornerRadius = 25.0
    }

    
    @IBAction func okBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
