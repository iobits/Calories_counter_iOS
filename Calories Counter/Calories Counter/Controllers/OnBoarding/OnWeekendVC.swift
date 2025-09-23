//
//  OnWeekendVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class OnWeekendCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
}

class OnWeekendVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let tabBarVC = CustomTabBarController()
                tabBarVC.modalPresentationStyle = .fullScreen
                self.present(tabBarVC, animated: true, completion: nil)
            default:
                print("Unknown View tapped")
            }
        }
    }

}

extension OnWeekendVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnWeekendCell", for: indexPath) as! OnWeekendCell
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 25
      
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
        return 70
    }
}

