//
//  SendingViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 20.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class SendingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlert()
    }
    
    func showAlert() {
        let alertActionStyle = UIAlertActionStyle.default
        let alertActionTitle = "Ok"
        let alertControllerPreferredStryle = UIAlertControllerStyle.alert
        let alertControllerTitle = "Сообщение успешно отправлено"
        
        //TODO: Check text
//        if self.textField.text.isEmpty {
//            alertActionStyle = .destructive
//            alertActionTitle = "Cancel"
//            alertControllerPreferredStryle = .actionSheet
//            alertControllerTitle = "Поле сообщения должно быть заполнено"
//        }
        
        let alertController = UIAlertController(
            title: alertControllerTitle,
            message: nil, preferredStyle: alertControllerPreferredStryle)
        
        let action = UIAlertAction(title: alertActionTitle, style: alertActionStyle) {
            (action) in
            
            //TODO: Check text
//            if !self.textField.text.isEmpty {
//                self.navigationController?.popToRootViewController(
//                    animated: true)
//            }
        }
        alertController.addAction(action)
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
}
