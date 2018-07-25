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
        updateBooleanProperties(false)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        updateBooleanProperties(true)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mdFeedBackManager = MDFeedBackManager(self)
        
        let mdFeedBackModel = MDFeedBackModel()
        mdFeedBackModel.mdFeedBackModelId = 104
        mdFeedBackModel.firstName = "Andrey"
        mdFeedBackModel.lastName = "Vasilyev"
        mdFeedBackModel.text = MDSingletonData.message
        mdFeedBackManager.postMDFeedBack(mdFeedBackModel)
    }
    
    func updateBooleanProperties(_ isActive: Bool) -> Void {
        application.isNetworkActivityIndicatorVisible = isActive
        
        isActive ?
            progressRing.startAnimating() :
            progressRing.stopAnimating()
    }
}
