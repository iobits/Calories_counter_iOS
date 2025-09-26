//
//  YourNutritionVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit

class YourNutritionVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var selectedIndex: Int = 0
    var trackingConsistencyStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorColor = .clear
        tapGesture()
        trackingConsistencyStr = Constant.shared.trackYouNutriArr[0].titleSt
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TakeYourMealVC") as! TakeYourMealVC
                vc.modalPresentationStyle = .fullScreen
                UserDefaults.standard.set(self.trackingConsistencyStr, forKey: DefaultKeys.shared.trackingConsistency)
                UserDefaults.standard.synchronize()
               
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
extension YourNutritionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.trackYouNutriArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeStleCell") as! LifeStleCell
        // Set background based on selected index
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 30
        let data = Constant.shared.trackYouNutriArr[indexPath.row]
        
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
        trackingConsistencyStr = Constant.shared.trackYouNutriArr[indexPath.row].titleSt
        tableView.reloadData() // Refresh table to update colors
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
