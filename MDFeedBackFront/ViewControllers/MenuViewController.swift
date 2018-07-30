//
//  MenuViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.orange
        if let backgroundImage = self.getBackgroundImage("backgroundImage4") {
            self.view.addSubview(backgroundImage)
            self.view.sendSubview(toBack: backgroundImage)
            self.setSquareConstraint(backgroundImage, self.view)
        }
        
        self.delegate = self
        
        //self.tabBar.tintColor = UIColor.orange
        //self.tabBar.unselectedItemTintColor = UIColor.gray
    }
    //    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) { }
}
