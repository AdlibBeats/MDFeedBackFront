//
//  MessageTextViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MessageTextViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateBooleanProperties(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateBooleanProperties(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUITextView), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUITextView), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func updateUITextView(sender: Notification) -> Void {
        guard let userInfo = sender.userInfo else { return }
        guard let nsValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = self.view.convert(nsValue.cgRectValue, to: self.view.window)
        if sender.name == Notification.Name.UIKeyboardWillHide {
            textView.contentInset = UIEdgeInsets.zero
        }
        else {
            textView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    @IBAction func onSendItemTouched(_ sender: UIBarButtonItem) {
        if textView.text.isEmpty {
            showError("Поле сообщения должно быть заполнено", self)
            return
        }
        
        MDSingletonData.message = textView.text
        
        goToSendingViewController()
    }
    
    func goToSendingViewController() -> Void {
        if let sendingViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "SendingViewController") as? SendingViewController {
            self.navigationController?.pushViewController(sendingViewController, animated: true)
        }
    }
    
    func updateBooleanProperties(_ isActive: Bool) -> Void {
        self.view.isHidden = isActive
        navigationController?.isNavigationBarHidden = isActive
        
        _ = isActive ?
            textView.resignFirstResponder() :
            textView.becomeFirstResponder()
    }
}
