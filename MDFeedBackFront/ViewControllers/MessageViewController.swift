//
//  MessageViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

//let mdFeedBackModel = MDFeedBackModel()
//mdFeedBackModel.mdFeedBackModelId = 8
//mdFeedBackModel.firstName = "Jack"
//mdFeedBackModel.lastName = "Vasilyev"
//mdFeedBackModel.text = "i sended message from iOS =)"

//mdFeedBackManager.getMDFeedBacks()
//mdFeedBackManager.getMDFeedBack(7)
//mdFeedBackManager.postMDFeedBacks(mdFeedBackModel)
//mdFeedBackManager.editMDFeedBack(mdFeedBackModel)
//mdFeedBackManager.deleteMDFeedBack(6)

import UIKit

//extension MessageViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MessageViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}

class MessageViewController: UIViewController {
    //@IBOutlet weak var firstNameTextField: UITextField!
    //@IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var goToInputTextButtun: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        updateBooleanProperties(false)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBooleanProperties(true)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToInputTextButtun.layer.cornerRadius = goToInputTextButtun.bounds.height / 2.5
        
        //self.hideKeyboardWhenTappedAround()
        
        //firstNameTextField.delegate = self
        //lastNameTextField.delegate = self
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (sender) in
//            self.view.frame.origin.y = -102
//        }
        
        
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (sender) in
//            self.view.frame.origin.y = 0.0
//        }
        
        //rotated()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    //@objc func rotated() -> Void {
        //rotation
    //}
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        if firstNameTextField == textField {
//            lastNameTextField.becomeFirstResponder()
//        }
//        else if lastNameTextField == textField {
//            goToMessageTextViewController()
//        }
//
//        return true
//    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) -> Void {
        goToMessageTextViewController()
    }
    
    func goToMessageTextViewController() -> Void {
        if let messageTextViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "MessageTextViewController") as? MessageTextViewController {
            self.navigationController?.pushViewController(messageTextViewController, animated: true)
        }
    }
    
    func updateBooleanProperties(_ isActive: Bool) -> Void {
        self.view.isHidden = !isActive
        navigationController?.isNavigationBarHidden = isActive
    }
}
