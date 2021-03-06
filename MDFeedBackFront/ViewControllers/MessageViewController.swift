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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToInputTextButtun.layer.cornerRadius = goToInputTextButtun.bounds.height / 2.0
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) -> Void {
        navigateTo(MessageTextViewController.self)
    }
}
