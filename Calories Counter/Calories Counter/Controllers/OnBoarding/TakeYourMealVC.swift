//
//  TakeYourMealVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class TakeYourMealCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    
}

class TakeYourMealVC: UIViewController {
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nextView: UIView!
    
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextView.layer.cornerRadius = 25.0
    }
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BadEatingHabbitVC") as! BadEatingHabbitVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

extension TakeYourMealVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TakeYourMealCell") as! TakeYourMealCell
        // Set background based on selected index
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 30
        
        if indexPath.row == selectedIndex {
            cell.mainView.layer.borderWidth = 2
            cell.mainView.layer.borderColor = UIColor.systemYellow.cgColor
            cell.mainView.layer.masksToBounds = true
            cell.mainView.backgroundColor = UIColor(hex: "#FFE98B")
        } else {
            cell.mainView.layer.borderWidth = 0   // Reset border
            cell.mainView.layer.borderColor = nil // Reset border color
            cell.mainView.backgroundColor = .white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData() // Refresh table to update colors
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
