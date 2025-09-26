//
//  CustomTabBarController.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//


import UIKit

class CustomTabBar: UITabBar {
    private let customHeight: CGFloat = 75
    private let bottomMargin: CGFloat = 20
    private let sideMargin: CGFloat = 10
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = customHeight + bottomMargin
        return size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // TabBar ka frame adjust
        var tabFrame = self.frame
        tabFrame.size.height = customHeight
        tabFrame.origin.y = self.superview!.frame.height - customHeight - bottomMargin
        tabFrame.origin.x = sideMargin
        tabFrame.size.width = self.superview!.frame.width - (sideMargin * 2)
        self.frame = tabFrame
        
        // Corner radius
        self.layer.cornerRadius = 35
        self.layer.masksToBounds = true
    }
}

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Replace system tabBar with CustomTabBar
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
        setupTabs()
        setupTabBarAppearance()
    }
    
    
    private func setupTabs() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Home
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.setNavigationBarHidden(true, animated: false)   // 👈 full view
        
        homeNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "home_unselected")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "home_selected")?.withRenderingMode(.alwaysOriginal)
        )
        
        // Meals
        let mealsVC = storyboard.instantiateViewController(withIdentifier: "FastingHomeVC") as! FastingHomeVC
        let mealsNav = UINavigationController(rootViewController: mealsVC)
        mealsNav.setNavigationBarHidden(true, animated: false)   // 👈 full view
        
        mealsNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "meals_unselected")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "meals_selected")?.withRenderingMode(.alwaysOriginal)
        )
        
        // Weight
        let weightVC = storyboard.instantiateViewController(withIdentifier: "WeightVC") as! WeightVC
        let weightNav = UINavigationController(rootViewController: weightVC)
        weightNav.setNavigationBarHidden(true, animated: false)   // 👈 full view
        
        weightNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "weight_unselected")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "weight_selected")?.withRenderingMode(.alwaysOriginal)
        )
        
        // Wellness
        let wellNesVC = storyboard.instantiateViewController(withIdentifier: "WellNessVC") as! WellNessVC
        let wellNav = UINavigationController(rootViewController: wellNesVC)
        wellNav.setNavigationBarHidden(true, animated: false)   // 👈 full view
        
        wellNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "wellness_unselected")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "wellness_selected")?.withRenderingMode(.alwaysOriginal)
        )
        
        // Static
        let staticVC = storyboard.instantiateViewController(withIdentifier: "StateVC") as! StateVC
        let statNav = UINavigationController(rootViewController: staticVC)
        statNav.setNavigationBarHidden(true, animated: false)   // 👈 full view
        
        statNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "state_unselected")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "state_selected")?.withRenderingMode(.alwaysOriginal)
        )
        
        // ✅ Sabhi items ko neeche shift karna
        [homeNav, mealsNav, weightNav, wellNav, statNav].forEach { nav in
            nav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -12, right: 0)
        }
        
        viewControllers = [homeNav, mealsNav, weightNav, wellNav, statNav]
    }


    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()   // solid background
        appearance.backgroundColor = .black          // 👈 apna color

        // Optional: line hide karna ho to
        appearance.shadowColor = nil

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance   // 👈 scroll karne par bhi same color
        }

        // Tint disable for custom icons
        tabBar.tintColor = nil
        tabBar.unselectedItemTintColor = nil
    }

}
