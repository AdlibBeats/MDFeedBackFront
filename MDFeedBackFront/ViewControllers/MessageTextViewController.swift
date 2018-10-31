//
//  MessageTextViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit
import RealmSwift

class MessageTextViewController: UIViewController, UITextViewDelegate {
    @IBOutlet private weak var textView: UITextView!
    
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
        
        DispatchQueue.global(qos: .background).async {
            [unowned self] in
            
            let textFromLocalStorage = self.getTextFromLocalStorage()
            DispatchQueue.main.async {
                self.textView.text = textFromLocalStorage
            }
        }
        textView.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateContentInsetFromTextView),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateContentInsetFromTextView),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func getTextFromLocalStorage() -> String? {
        do {
            let realm = try Realm()
            guard let mdFeedBackModel = realm.objects(MDFeedBackModel.self).first else {
                print("MD Not found (\(type(of: self))): Объект Realm не найден.")
                return nil
            }
            return mdFeedBackModel.text
        }
        catch let error as NSError {
            print("MD Exception (\(type(of: self))): \(error)")
        }
        return nil
    }
    
    private func updateTextFromLocalStorage(_ text: String) -> Void {
        DispatchQueue.global(qos: .background).async {
            [unowned self] in
            
            do {
                let realm = try Realm()
                do {
                    try realm.write {
                        let mdFeedBackModel = MDFeedBackModel()
                        mdFeedBackModel.text = text
                        realm.add(mdFeedBackModel, update: true)
                    }
                }
                catch let error as NSError {
                    print("MD Exception (\(type(of: self))): \(error)")
                }
            }
            catch let error as NSError {
                print("MD Exception (\(type(of: self))): \(error)")
            }
        }
    }
    
    open func textViewDidChange(_ textView: UITextView) {
        updateTextFromLocalStorage(textView.text)
    }
    
    @objc func updateContentInsetFromTextView(sender: Notification) -> Void {
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
