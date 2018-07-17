//
//  MessageViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessageViewController: UIViewController, MDFeedBackDelegate {
    func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) {
        mdFeedBackManager.getMDFeedBacksLoaded(response)
    }
    
    func getMDFeedBackLoaded(_ response: DataResponse<Any>?) {
        mdFeedBackManager.getMDFeedBackLoaded(response)
    }
    
    func postMDFeedBackLoaded(_ response: DataResponse<Any>?) {
        mdFeedBackManager.postMDFeedBackLoaded(response)
    }
    
    func editMDFeedBackLoaded(_ response: DataResponse<Any>?) {
        mdFeedBackManager.editMDFeedBackLoaded(response)
    }
    
    func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) {
        mdFeedBackManager.deleteMDFeedBackLoaded(response)
    }
    
    var mdFeedBackManager = MDFeedBackManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mdFeedBackManager = MDFeedBackManager(self)
        
        //        let mdFeedBackModel = MDFeedBackModel()
        //        mdFeedBackModel.mdFeedBackModelId = 8
        //        mdFeedBackModel.firstName = "Jack"
        //        mdFeedBackModel.lastName = "Vasilyev"
        //        mdFeedBackModel.text = "i sended message from iOS =)"
        
        mdFeedBackManager.getMDFeedBacks()
        //mdFeedBackManager.getMDFeedBack(7)
        //mdFeedBackManager.postMDFeedBacks(mdFeedBackModel)
        //mdFeedBackManager.editMDFeedBack(mdFeedBackModel)
        //mdFeedBackManager.deleteMDFeedBack(6)
        
    }
}
