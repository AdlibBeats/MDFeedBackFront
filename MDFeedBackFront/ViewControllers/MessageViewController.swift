//
//  MessageViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

//let mdFeedBackModel = MDFeedBackModel()
//mdFeedBackModel.mdFeedBackModelId = 8
//mdFeedBackModel.firstName = "Jack"
//mdFeedBackModel.lastName = "Vasilyev"
//mdFeedBackModel.text = "i sended message from iOS =)"

//mdFeedBackManager.getMDFeedBacks()
//mdFeedBackManager.getMDFeedBack(7)
//mdFeedBackManager.postMDFeedBacks(mdFeedBackModel)
//mdFeedBackManager.editMDFeedBack(mdFeedBackModel)
//mdFeedBackManager.deleteMDFeedBack(6)

import UIKit

class MessageViewController: UIViewController {
    
    var mdFeedBackManager = MDFeedBackManager()
    
    @IBOutlet weak var goToInputTextButtun: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let image = UIImage(named: "backgroundImage") {
//            self.view.backgroundColor = UIColor(patternImage: image)
//        }
        
        mdFeedBackManager = MDFeedBackManager(self)
        //mdFeedBackManager.getMDFeedBacks()
    }
    
    //self.navigationController?.pushViewController(secondVC, animated: true)
    
    
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        if let messageTextViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "MessageTextViewController") as? MessageTextViewController {
        self.navigationController?.pushViewController(messageTextViewController, animated: true)
        }
    }
}
