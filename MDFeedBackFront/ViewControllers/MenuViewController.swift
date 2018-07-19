//
//  MenuViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        if let uiImageView = getBackgroundImage("backgroundImage") {
            self.view.addSubview(uiImageView)
            self.view.sendSubview(toBack: uiImageView)
            setSquareConstraint(uiImageView)
        }
    }
    
    func setSquareConstraint(_ view: UIView) -> Void {
        NSLayoutConstraint(
            item: view,
            attribute: .left,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .left,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: view,
            attribute: .right,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .right,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: view,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0).isActive = true
    }
    
    func getBackgroundImage(_ named: String) -> UIImageView? {
        if let uiImage = UIImage(named: named) {
            let uiImageView = UIImageView(image: uiImage)
            uiImageView.contentMode = .scaleAspectFill
            uiImageView.alpha = 0.9
            uiImageView.translatesAutoresizingMaskIntoConstraints = false
            
            return uiImageView
        }
        else {
            return nil
        }
    }
}
