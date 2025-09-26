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
    var weekendEatingStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        weekendEatingStr = Constant.shared.bitMoreArr[0].titleSt
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
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProgressVC") as! ProgressVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.weekendEatingStr, forKey: DefaultKeys.shared.weekendEating)
                UserDefaults.standard.synchronize()
                
                self.present(vc, animated: false)
                
            default:
                print("Unknown View tapped")
            }
        }
    }

}

extension OnWeekendVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.bitMoreArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnWeekendCell", for: indexPath) as! OnWeekendCell
        let data = Constant.shared.bitMoreArr[indexPath.row]
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 25
        cell.imgView.image = UIImage(named: data.img)
        cell.titleLbl.text = data.titleSt
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
        weekendEatingStr = Constant.shared.bitMoreArr[indexPath.row].titleSt
        tableView.reloadData() // Refresh table to update colors
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

