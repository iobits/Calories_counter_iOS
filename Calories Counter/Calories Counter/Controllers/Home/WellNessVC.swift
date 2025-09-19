//
//  WellNessVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 17/09/2025.
//

import UIKit

class WellNessCell: UICollectionViewCell{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.numberOfLines = 0
        titleLbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
}

class WellNessVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var waterIntakeView: UIView!
    
    let titles = [
           "Is sugar really that bad for you",
           "Fasting: Facts vs. Fiction",
           "Why It’s to eat with those you love",
           "Stay hydrated every day",
           "How sleep affects your health",
           "5 benefits of daily walking",
           "Mindfulness for beginners",
           "Yoga for stress relief",
           "Importance of breakfast",
           "Balanced diet essentials"
       ]
       
       let images = [
           "sugar", "fasting", "egg", "water", "sleep",
           "walking", "mindfulness", "yoga", "breakfast", "diet"
       ]
       
       let colors: [UIColor] = [
           .systemYellow, .systemGreen, .systemPink,
           .systemBlue, .systemOrange, .systemPurple,
           .systemTeal, .systemMint, .systemRed, .systemIndigo
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [waterIntakeView].viewsCornerRadius(15)
    }
}

extension WellNessVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WellNessCell", for: indexPath) as! WellNessCell
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    // Cell size (3 cards per row)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 180)
    }
    
    // Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}
