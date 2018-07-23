//
//  MenuViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController, UITabBarControllerDelegate {

    var backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        //self.tabBar.tintColor = UIColor.orange
        //self.tabBar.unselectedItemTintColor = UIColor.gray
        
        self.view.backgroundColor = UIColor.white
        if let uiImageView = self.getBackgroundImage("backgroundImage4") {
            backgroundImage = uiImageView
            self.view.addSubview(backgroundImage)
            self.view.sendSubview(toBack: backgroundImage)
            self.setSquareConstraint(backgroundImage, self.view)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch tabBar.selectedItem?.title {
        case "Home":
            backgroundImage.image = UIImage(named: "backgroundImage4")
            break
        case "Info":
            backgroundImage.image = UIImage(named: "backgroundImage4")
            break
        default:
            break
        }
    }
}