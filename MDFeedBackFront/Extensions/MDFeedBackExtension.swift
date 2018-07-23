//
//  MDFeedBackExtension.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 18.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire

extension SendingViewController: MDFeedBackDelegate {
    func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.getMDFeedBacksLoaded(response)
    }
    
    func getMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.getMDFeedBackLoaded(response)
    }

    func postMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        updateBooleanProperties(false)
        
        let result = mdFeedBackManager.postMDFeedBackLoaded(response)
        
        if result {
            showContinue(self, goToRoot)
        }
        else {
            showError("Сообщение не удалось отправить", self, goBack)
        }
        
        return result
    }
    
    func editMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.editMDFeedBackLoaded(response)
    }
    
    func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.deleteMDFeedBackLoaded(response)
    }
    
    func updateBooleanProperties(_ isActive: Bool) -> Void {
        isActive ? progressRing.startAnimating() : progressRing.stopAnimating()
        application.isNetworkActivityIndicatorVisible = isActive
    }
}

extension UIViewController {
    
    func showContinue(_ viewController: UIViewController, _ continueAction: ((_ viewController: UIViewController) -> Void)?) -> Void {
        let uiAlertController = getNewUIAlertController("Сообщение успешно отправлено", .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {
            (action) in
            
            continueAction?(viewController)
        }
        uiAlertController.addAction(action)
        self.present(
            uiAlertController,
            animated: true,
            completion: nil)
    }
    
    func showError(_ errorMessage: String, _ viewController: UIViewController, _ errorAction: ((_ viewController: UIViewController) -> Void)? = nil) -> Void {
        let uiAlertController = getNewUIAlertController(errorMessage, .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .destructive) {
            (action) in
            
            errorAction?(viewController)
        }
        uiAlertController.addAction(action)
        self.present(
            uiAlertController,
            animated: true,
            completion: nil)
    }
    
    func goBack(_ viewController: UIViewController) -> Void {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func goToRoot(_ viewController: UIViewController) -> Void {
       viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func getNewUIAlertController(
        _ alertControllerTitle: String,
        _ alertControllerPreferredStryle: UIAlertControllerStyle) -> UIAlertController {
        let uiAlertController = UIAlertController(
            title: alertControllerTitle,
            message: nil, preferredStyle: alertControllerPreferredStryle)
        return uiAlertController
    }
    
    func getBackgroundImage(_ named: String) -> UIImageView? {
        if let uiImage = UIImage(named: named) {
            let uiImageView = UIImageView(image: uiImage)
            uiImageView.contentMode = .scaleAspectFill
            uiImageView.alpha = 0.8
            uiImageView.translatesAutoresizingMaskIntoConstraints = false
            
            return uiImageView
        }
        else {
            return nil
        }
    }
    
    func setSquareConstraint(_ childView: UIView, _ rootView: UIView) -> Void {
        NSLayoutConstraint(
            item: childView,
            attribute: .left,
            relatedBy: .equal,
            toItem: rootView,
            attribute: .left,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: childView,
            attribute: .right,
            relatedBy: .equal,
            toItem: rootView,
            attribute: .right,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: childView,
            attribute: .top,
            relatedBy: .equal,
            toItem: rootView,
            attribute: .top,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: childView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: rootView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0).isActive = true
    }
}
