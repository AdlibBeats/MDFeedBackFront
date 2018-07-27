//
//  MessageTextViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit
import RealmSwift

class TextModel : Object {
    @objc dynamic var textModelId = 0
    @objc dynamic var message = ""
    @objc dynamic var completed = false
    
    override class func primaryKey() -> String? {
        return "textModelId"
    }
}

class MessageTextViewController: UIViewController, UITextViewDelegate {
    
    let textModel = TextModel()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    // fix
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.isHidden = true
        textView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.isHidden = false
        textView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTextView()
        textView.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateUITextView),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateUITextView),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
    }
    
    func updateTextView() {
        do {
            let realm = try Realm()
            guard let textModel = realm.objects(TextModel.self).first else { return }
            textView.text = textModel.message
        }
        catch let error as NSError {
            print("MD Exception: \(error)")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard self.textView == textView else { return }
        do {
            let realm = try Realm()
            try! realm.write {
                textModel.message = self.textView.text
                realm.add(textModel, update: true)
            }
        }
        catch let error as NSError {
            print("MD Exception: \(error)")
        }
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
}
