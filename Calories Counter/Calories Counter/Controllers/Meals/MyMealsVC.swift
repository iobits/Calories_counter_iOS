//
//  MyMealsVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 23/09/2025.
//

import UIKit
import CoreData

class MyMealCellTop: UICollectionViewCell{
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureCell(title: String, isSelected: Bool) {
        titleLabel.text = title
        bgView.layer.cornerRadius = 15
       
        if isSelected {
            // ✅ Selected cell = RED
            bgView.backgroundColor = UIColor(hex: "#FFE98B").withAlphaComponent(1.0)
            titleLabel.textColor = .black
        } else {
            // ✅ Unselected cells = YELLOW
            bgView.backgroundColor = UIColor(hex: "#FFE98B").withAlphaComponent(0.4)
            titleLabel.textColor = .darkGray
        }
    }
}

class MyMealCell: UICollectionViewCell{
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mealTypeLbl: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
}

class MyMealsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topCollcetionView: UICollectionView!
    @IBOutlet weak var noDatImg: UIImageView!
    
    let categories = ["Breakfast", "Lunch", "Snacks", "Dinner"]
    var selectedCategoryIndex: Int = 0
    // CoreData arrays
    var lunchArr: [Lunch] = []
    var snackArr: [Snacks] = []
    var dinnerArr: [Dinner] = []
    var breakFastArr: [Breakfast] = []
    
    // Active array (for selected category)
    var currentMeals: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch CoreData arrays
        lunchArr = CoreDataManager.shared.fetchLunch() ?? []
        snackArr = CoreDataManager.shared.fetchSnacks() ?? []
        dinnerArr = CoreDataManager.shared.fetchDinner() ?? []
        breakFastArr = CoreDataManager.shared.fetchBreakfast() ?? []
        
        // Default selection = Breakfast
        currentMeals = breakFastArr
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        topCollcetionView.delegate = self
        topCollcetionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        topCollcetionView.showsHorizontalScrollIndicator = false
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
            return currentMeals.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollcetionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyMealCellTop", for: indexPath) as! MyMealCellTop
            let isSelected = indexPath.item == selectedCategoryIndex
            cell.configureCell(title: categories[indexPath.item], isSelected: isSelected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyMealCell", for: indexPath) as! MyMealCell
            cell.bgView.layer.cornerRadius = 15.0
            cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width/2
            cell.imgView.clipsToBounds = true
            
            if let meal = currentMeals[indexPath.item] as? Breakfast {
                cell.mealTypeLbl.text = meal.mealType
                cell.mealName.text = meal.name
                cell.caloriesLbl.text = meal.calories
                if let data = meal.imageData {
                    cell.imgView.image = UIImage(data: data)   // ✅ convert Data -> UIImage
                }
                if let date = meal.date { cell.dateLbl.text = formatDate(date) }
            } else if let meal = currentMeals[indexPath.item] as? Lunch {
                cell.mealTypeLbl.text = meal.mealType
                cell.mealName.text = meal.name
                cell.caloriesLbl.text = meal.calories
                if let data = meal.imageData {
                    cell.imgView.image = UIImage(data: data)   // ✅ convert Data -> UIImage
                }
                if let date = meal.date { cell.dateLbl.text = formatDate(date) }
            } else if let meal = currentMeals[indexPath.item] as? Snacks {
                cell.mealTypeLbl.text = meal.mealType
                cell.mealName.text = meal.name
                cell.caloriesLbl.text = meal.calories
                if let data = meal.imageData {
                    cell.imgView.image = UIImage(data: data)   // ✅ convert Data -> UIImage
                }
                if let date = meal.date { cell.dateLbl.text = formatDate(date) }
            } else if let meal = currentMeals[indexPath.item] as? Dinner {
                cell.mealTypeLbl.text = meal.mealType
                cell.mealName.text = meal.name
                cell.caloriesLbl.text = meal.calories
                if let data = meal.imageData {
                    cell.imgView.image = UIImage(data: data)   // ✅ convert Data -> UIImage
                }
                if let date = meal.date { cell.dateLbl.text = formatDate(date) }
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topCollcetionView {
            selectedCategoryIndex = indexPath.item   // 👉 Save selected index
            
            switch categories[indexPath.item] {
            case "Breakfast":
                currentMeals = breakFastArr
            case "Lunch":
                currentMeals = lunchArr
            case "Snacks":
                currentMeals = snackArr
            case "Dinner":
                currentMeals = dinnerArr
            default:
                currentMeals = []
            }
            
            // ✅ Refresh both collections
            topCollcetionView.reloadData()
            self.collectionView.reloadData()
        }
    }
        
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"   // 👉 Example: 01 Aug, 2025
        return formatter.string(from: date)
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
