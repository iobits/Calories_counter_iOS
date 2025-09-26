//
//  BadEatingHabbitVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class BadEatingCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
}

class BadEatingHabbitVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nextView: UIView!
    
    var selectedIndex: Int = 0
    var badEatingHabitsStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorColor = .clear
        tblView.showsVerticalScrollIndicator = false
        tapGesture()
        let data = Constant.shared.badEatingArr[0]
        badEatingHabitsStr = data.titleSt
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextView.layer.cornerRadius = 25.0
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tapGesture() {
        [nextView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourDietTypeVC") as! YourDietTypeVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.badEatingHabitsStr, forKey: DefaultKeys.shared.badEatingHabits)
                UserDefaults.standard.synchronize()
                
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

extension BadEatingHabbitVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.badEatingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadEatingCell", for: indexPath) as! BadEatingCell
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 25
        let data = Constant.shared.badEatingArr[indexPath.row]
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
        let data = Constant.shared.badEatingArr[indexPath.row]
        badEatingHabitsStr = data.titleSt
        tableView.reloadData() // Refresh table to update colors
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

