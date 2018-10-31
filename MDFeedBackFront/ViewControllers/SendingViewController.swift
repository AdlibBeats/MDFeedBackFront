//
//  SendingViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 20.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit
import RealmSwift

class SendingViewController: UIViewController {
    @IBOutlet weak var progressRing: UIActivityIndicatorView!
    
    var mdFeedBackManager: MDFeedBackManager {
        return MDFeedBackManager(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
        progressRing.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        progressRing.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendMessage()
    }
    
    private func sendMessage() -> Void {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            do {
                let realm = try Realm()
                guard let mdFeedBackModel = realm.objects(MDFeedBackModel.self).first else {
                    print("MD Not found (\(type(of: self))): Объект Realm не найден.")
                    return
                }
                _ = self.mdFeedBackManager.postMDFeedBack(mdFeedBackModel)
            }
            catch let error as NSError {
                print("MD Exception (\(type(of: self))): \(error)")
            }
        }
    }
}
