//
//  MDFeedBackExtension.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 18.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire
import RealmSwift

extension SendingViewController: MDFeedBackDelegate {
    func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.getMDFeedBacksLoaded(response)
    }
    
    func getMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.getMDFeedBackLoaded(response)
    }

    func postMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard mdFeedBackManager.postMDFeedBackLoaded(response) else {
            showError("Сообщение не удалось отправить", goBack)
            return false
        }
        
        DispatchQueue.global(qos: .background).async {
            [unowned self] in
            do {
                let realm = try Realm()
                do {
                    try realm.write {
                        realm.deleteAll()
                    }
                }
                catch let error as NSError {
                    print("MD Exception (\(type(of: self))): \(error)")
                }
            }
            catch let error as NSError {
                print("MD Exception (\(type(of: self))): \(error)")
            }
            DispatchQueue.main.async {
                self.showContinue(self.goToRoot)
            }
        }
        return true
    }
    
    func editMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.editMDFeedBackLoaded(response)
    }
    
    func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return mdFeedBackManager.deleteMDFeedBackLoaded(response)
    }
}

extension UIViewController {
    func goBack(_ animated: Bool = true) -> Void {
        navigationController?.popViewController(animated: animated)
    }
    
    func goToRoot(_ animated: Bool = true) -> Void {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func navigateTo<T: UIViewController>(_ type: T.Type, _ animated: Bool = true) -> Void {
        if let sourceViewController = storyboardInstance(String(describing: type)) {
            navigationController?.pushViewController(sourceViewController, animated: animated)
        }
    }
    
    func storyboardInstance<T: UIViewController>(_ withIdentifier: String) -> T? {
        return storyboard?.instantiateViewController(withIdentifier: withIdentifier) as? T
    }
    
    func showContinue(
        _ continueAction: ((_ animated: Bool) -> Void)? = nil,
        _ animated: Bool = true) -> Void {
        
        let uiAlertController = getNewUIAlertController("Сообщение успешно отправлено", .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {
            (action) in
            
            continueAction?(animated)
        }
        uiAlertController.addAction(action)
        present(
            uiAlertController,
            animated: true,
            completion: nil)
    }
    
    func showError(
        _ errorMessage: String,
        _ errorAction: ((_ animated: Bool) -> Void)? = nil,
        _ animated: Bool = true) -> Void {
        
        let uiAlertController = getNewUIAlertController(errorMessage, .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .destructive) {
            (action) in
            
            errorAction?(animated)
        }
        uiAlertController.addAction(action)
        present(
            uiAlertController,
            animated: true,
            completion: nil)
    }
    
    func getNewUIAlertController(
        _ alertControllerTitle: String,
        _ alertControllerPreferredStryle: UIAlertControllerStyle) -> UIAlertController {
        
        return UIAlertController(
            title: alertControllerTitle,
            message: nil,
            preferredStyle: alertControllerPreferredStryle)
    }
    
    func getBackgroundImage(_ named: String) -> UIImageView? {
        guard let uiImage = UIImage(named: named) else {
            print("MD Error (\(type(of: self))): не удалось найти изображение \(named)")
            return nil
        }
        
        let uiImageView = UIImageView(image: uiImage)
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.alpha = 1.0
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
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
        NSLayoutConstraint(
            item: childView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: rootView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: childView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: rootView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0).isActive = true
    }
}
