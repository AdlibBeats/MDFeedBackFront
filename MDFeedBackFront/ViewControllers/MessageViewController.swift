//
//  MessageViewController.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 19.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    @IBOutlet weak var goToInputTextButtun: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        view.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        view.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToInputTextButtun.layer.cornerRadius = goToInputTextButtun.bounds.height / 2.0
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) -> Void {
        if let messageTextViewController = storyboard?.instantiateViewController(
            withIdentifier: "MessageTextViewController") {
            navigationController?.pushViewController(messageTextViewController, animated: true)
        }
    }
}
