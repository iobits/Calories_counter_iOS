//
//  MyMealsVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 23/09/2025.
//

import UIKit

class MyMealCellTop: UICollectionViewCell{
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                bgView.backgroundColor = UIColor(hex: "#FFE98B").withAlphaComponent(1.0)
                titleLabel.textColor = .black
            } else {
                bgView.backgroundColor =  UIColor(hex: "#FFE98B").withAlphaComponent(0.4)
                titleLabel.textColor = .darkGray
            }
        }
    }
}

class MyMealCell: UICollectionViewCell{
    
    @IBOutlet weak var bgView: UIView!
    
}

class MyMealsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topCollcetionView: UICollectionView!
    @IBOutlet weak var noDatImg: UIImageView!
    
    let categories = ["Lunch", "Breakfast", "Snacks", "Dinner"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        topCollcetionView.delegate = self
        topCollcetionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        topCollcetionView.showsHorizontalScrollIndicator = false
        
        DispatchQueue.main.async {
            let firstIndex = IndexPath(item: 0, section: 0)
            self.topCollcetionView.selectItem(at: firstIndex, animated: false, scrollPosition: [])
            if let firstCell = self.topCollcetionView.cellForItem(at: firstIndex) as? MyMealCellTop {
                firstCell.isSelected = true
            }
        }
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MyMealsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    // UICollectionViewDelegate, UICollectionViewDataSource functions
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollcetionView {
            return categories.count
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollcetionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyMealCellTop", for: indexPath) as! MyMealCellTop
            cell.bgView.layer.cornerRadius = 15
            cell.titleLabel.text = categories[indexPath.item]
            
            // ✅ Properly restore selection state
            // ✅ Properly restore selection state
            if cell.isSelected {
                cell.bgView.backgroundColor = UIColor(hex: "#FFE98B").withAlphaComponent(1.0) // solid
                cell.titleLabel.textColor = .black
            } else {
                cell.bgView.backgroundColor = UIColor(hex: "#FFE98B").withAlphaComponent(0.4) // lighter (40% opacity)
                cell.titleLabel.textColor = .darkGray
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyMealCell", for: indexPath) as! MyMealCell
            cell.bgView.layer.cornerRadius = 15.0
            return cell
        }
    }
}

// extention for UICollectionViewDelegateFlowLayout
extension MyMealsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2 // har row me 3 cells
        let spacing: CGFloat = 10 // line spacing
        let sectionInsets = CGFloat(5 * 2) // left + right insets
        
        let totalSpacing = (itemsPerRow - 1) * spacing + sectionInsets
        let availableWidth = collectionView.bounds.width - totalSpacing
        
        let cellWidth = floor(availableWidth / itemsPerRow)
        
        return CGSize(width: cellWidth, height: cellWidth + 80) // square cells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
