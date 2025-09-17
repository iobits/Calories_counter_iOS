//
//  LifeStyleLikeVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 15/09/2025.
//

import UIKit

class LifeStleCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
}

class LifeStyleLikeVC: UIViewController {

    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var tblView: UITableView!
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.separatorColor = .clear
        tblView.showsVerticalScrollIndicator = false
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoYouWorkVC") as! DoYouWorkVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            default:
                print("Unknown View tapped")
            }
        }
    }
}
extension LifeStyleLikeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.shared.LikeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeStleCell") as! LifeStleCell
        // Set background based on selected index
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 30
        let data = Constant.shared.LikeArr[indexPath.row]
        
        cell.imgView.image = UIImage(named: data.img)
        cell.titleLbl.text = data.titleSt
        cell.detailLbl.text = data.detailSt
        if indexPath.row == selectedIndex {
            cell.mainView.backgroundColor = UIColor(hex: "#FFE98B")
        } else {
            cell.mainView.backgroundColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData() // Refresh table to update colors
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
