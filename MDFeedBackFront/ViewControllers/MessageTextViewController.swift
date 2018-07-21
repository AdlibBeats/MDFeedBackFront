//
//  MessageTextViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MessageTextViewController: UIViewController, UITextFieldDelegate {
    
    var mdFeedBackManager = MDFeedBackManager()
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mdFeedBackManager = MDFeedBackManager(self)
        
        //textField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUITextView), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUITextView), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func updateUITextView(sender: Notification) -> Void {
        if let userInfo = sender.userInfo {
            if let nsValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = self.view.convert(nsValue.cgRectValue, to: self.view.window)
                if sender.name == Notification.Name.UIKeyboardWillHide {
                    textField.contentInset = UIEdgeInsets.zero
                }
                else {
                    textField.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
                    textField.scrollIndicatorInsets = textField.contentInset
                }
            }
        }
        textField.scrollRangeToVisible(textField.selectedRange)
    }
    
    @IBAction func onSendItemTouched(_ sender: UIBarButtonItem) {
        if textField.text.isEmpty {
            showError("Поле сообщения должно быть заполнено")
            return
        }
        
        let mdFeedBackModel = MDFeedBackModel()
        mdFeedBackModel.firstName = "default"
        mdFeedBackModel.lastName = "default"
        mdFeedBackModel.text = self.textField.text
        mdFeedBackManager.postMDFeedBack(mdFeedBackModel)
        //showAlert()
    }
    
    
    
    //MARK: Navigation to
//    func goToSendingViewController() -> Void {
//        if let sendingViewController = self.storyboard?.instantiateViewController(
//            withIdentifier: "SendingViewController") as? SendingViewController {
//            self.navigationController?.pushViewController(sendingViewController, animated: true)
//        }
//    }
}
