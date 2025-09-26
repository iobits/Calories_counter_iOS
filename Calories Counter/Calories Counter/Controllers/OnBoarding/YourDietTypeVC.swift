//
//  YourDietTypeVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class YourDietTypeCell: UITableViewCell{
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
}

class YourDietTypeVC: UIViewController {

    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var selectedIndex: Int = 0
    var dietTypeStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorStyle = .none
        tblView.showsVerticalScrollIndicator = false
        tapGesture()
        let data = Constant.shared.DietTypeArr[0]
        dietTypeStr = data.detailSt
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DietryRestictionVC") as! DietryRestictionVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.dietTypeStr, forKey: DefaultKeys.shared.dietType)
                UserDefaults.standard.synchronize()
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}

extension YourDietTypeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.DietTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourDietTypeCell") as! YourDietTypeCell
        // Set background based on selected index
        let data = Constant.shared.DietTypeArr[indexPath.row]
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 30
        cell.imgView.image = UIImage(named: data.img)
        cell.titleLbl.text = data.titleSt
        cell.detailLbl.text = data.detailSt
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
        let data = Constant.shared.DietTypeArr[indexPath.row]
        dietTypeStr = data.detailSt
        tableView.reloadData() // Refresh table to update colors
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
