//
//  SendingViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 20.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class SendingViewController: UIViewController {

    @IBOutlet weak var progressRing: UIActivityIndicatorView!
    
    let application = UIApplication.shared
    var mdFeedBackManager = MDFeedBackManager()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
        mdFeedBackModel.text = MDSingletonData.message
        _ = mdFeedBackManager.postMDFeedBack(mdFeedBackModel)
    }
    
    func updateBooleanProperties(_ isActive: Bool) -> Void {
        application.isNetworkActivityIndicatorVisible = isActive
        
        isActive ?
            progressRing.startAnimating() :
            progressRing.stopAnimating()
    }
}
