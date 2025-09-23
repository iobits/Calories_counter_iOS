//
//  ReachingGoalsVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class ReachingGoalsCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
}

class ReachingGoalsVC: UIViewController {
    
    @IBOutlet weak var goalTblView: UITableView!
    @IBOutlet weak var nextView: UIView!
    
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTblView.delegate = self
        goalTblView.dataSource = self
        goalTblView.separatorColor = .clear
        goalTblView.showsVerticalScrollIndicator = false
        tapGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextView.layer.cornerRadius = 25
    }
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LifeStyleLikeVC") as! LifeStyleLikeVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

extension ReachingGoalsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.reachingGoalsArra.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReachingGoalsCell", for: indexPath) as! ReachingGoalsCell
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 25
        let data = Constant.shared.reachingGoalsArra[indexPath.row]
        cell.titleLbl.text = data.titleSt
        cell.imgView.image = UIImage(named: data.img)
        // Set background based on selected index
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
