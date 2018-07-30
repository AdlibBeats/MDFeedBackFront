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
        
        tabBar.tintColor = UIColor.orange
        if let backgroundImage = getBackgroundImage("backgroundImage4") {
            view.insertSubview(backgroundImage, at: 0)
            setSquareConstraint(backgroundImage, view)
        }
        
        //delegate = self
    }
    //    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) { }
}
