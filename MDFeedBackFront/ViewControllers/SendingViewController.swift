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
    
    let application = UIApplication.shared
    var mdFeedBackManager = MDFeedBackManager()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        updateBooleanProperties(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        updateBooleanProperties(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mdFeedBackManager = MDFeedBackManager(self)
        
        let mdFeedBackModel = MDFeedBackModel()
        //mdFeedBackModel.mdFeedBackModelId = ... on editMDFeedBack
        mdFeedBackModel.firstName = "default"
        mdFeedBackModel.lastName = "default"
        
        do {
            let realm = try Realm()
            guard let textModel = realm.objects(TextModel.self).first else { return }
            mdFeedBackModel.text = textModel.message
        }
        catch let error as NSError {
            print("MD Exception: \(error)")
        }
        _ = mdFeedBackManager.postMDFeedBack(mdFeedBackModel)
    }
    
    func updateBooleanProperties(_ isActive: Bool) -> Void {
        application.isNetworkActivityIndicatorVisible = isActive
        
        isActive ?
            progressRing.startAnimating() :
            progressRing.stopAnimating()
    }
}
