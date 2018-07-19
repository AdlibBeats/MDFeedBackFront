//
//  MenuViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MenuViewController: UITabBarController, UITabBarControllerDelegate {

    var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.view.backgroundColor = UIColor.white
        if let uiImageView = getBackgroundImage("backgroundImage") {
            backgroundImage = uiImageView
            self.view.addSubview(backgroundImage)
            self.view.sendSubview(toBack: backgroundImage)
            setSquareConstraint(backgroundImage)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch tabBar.selectedItem?.title {
        case "Home":
            updateBackgroundImage("backgroundImage")
            break
        case "Send message":
            updateBackgroundImage("backgroundImage")
            break
        case "Info":
            updateBackgroundImage("backgroundImage2")
            break
        default:
            break
        }
    }
    
    func updateBackgroundImage(_ named: String) -> Void {
        backgroundImage.image = UIImage(named: named)
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
