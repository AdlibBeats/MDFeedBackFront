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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        guard textView == textView else { return }
        do {
            let realm = try Realm()
            do {
                try realm.write {
                    textModel.message = textView.text
                    realm.add(textModel, update: true)
                }
            }
            catch let error as NSError {
                print("MD Exception: \(error)")
            }
        }
        catch let error as NSError {
            print("MD Exception: \(error)")
        }
    }
    
    @objc func updateUITextView(sender: Notification) -> Void {
        guard let userInfo = sender.userInfo else { return }
        guard let nsValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = view.convert(nsValue.cgRectValue, to: view.window)
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
            showError("Поле сообщения должно быть заполнено")
            return
        }
        navigateTo(SendingViewController.self)
    }
}
