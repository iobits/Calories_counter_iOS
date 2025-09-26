//
//  DoYouWorkVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class DoYouWorkCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
}

class DoYouWorkVC: UIViewController {

    var selectedIndex: Int = 0
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nextView: UIView!
    var anyWorkArr = ["6-7 days a week", "3-5 days a week", "1-2 days a week", "Less", "Never"]
    var workoutsStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.separatorColor = .clear
        tblView.showsVerticalScrollIndicator = false
        tblView.delegate = self
        tblView.dataSource = self
        tapGesture()
        workoutsStr =  anyWorkArr[0]
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HowFastVC") as! HowFastVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.workoutsStr, forKey: DefaultKeys.shared.workouts)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
extension DoYouWorkVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anyWorkArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoYouWorkCell") as! DoYouWorkCell
        // Set background based on selected index
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 25
        cell.titleLbl.text = anyWorkArr[indexPath.row]
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
        workoutsStr =  anyWorkArr[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
