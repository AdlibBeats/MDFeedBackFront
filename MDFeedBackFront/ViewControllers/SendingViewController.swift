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
    
    var mdFeedBackManager = MDFeedBackManager()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        navigationController?.isNavigationBarHidden = false
        progressRing.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        navigationController?.isNavigationBarHidden = true
        progressRing.startAnimating()
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
}
