//
//  YourGoalsVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class YourGoalsCell: UITableViewCell{
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
}

class YourGoalsVC: UIViewController {

    @IBOutlet weak var goalTblView: UITableView!
    @IBOutlet weak var nextView: UIView!
    
    var selectedIndex: Int = 0
    var motivationStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTblView.delegate = self
        goalTblView.dataSource = self
        goalTblView.separatorColor = .clear
        goalTblView.showsVerticalScrollIndicator = false
        tapGesture()
        motivationStr = Constant.shared.motivateArr[0].titleSt
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextView.layer.cornerRadius = 25
    }
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReachingGoalsVC") as! ReachingGoalsVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.motivationStr, forKey: DefaultKeys.shared.motivation)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

extension YourGoalsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.motivateArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourGoalsCell", for: indexPath) as! YourGoalsCell
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 25
        let data = Constant.shared.motivateArr[indexPath.row]
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
        let data = Constant.shared.motivateArr[indexPath.row]
        tableView.reloadData() // Refresh table to update colors
        motivationStr = data.titleSt
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
