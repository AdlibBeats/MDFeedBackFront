//
//  MDFeedBackModel.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import RealmSwift

open class MDFeedBackModel : Object {
    @objc dynamic open var mdFeedBackModelId = 0
    @objc dynamic open var text = "default"
    @objc dynamic open var firstName = "default"
    @objc dynamic open var lastName = "default"
    
    override open class func primaryKey() -> String? {
        return "mdFeedBackModelId"
    }
}
