//
//  MDFeedBackModel.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

open class MDFeedBackModel {
    
    private var _mdFeedBackModelId = Int()
    open var mdFeedBackModelId: Int {
        get {
            return _mdFeedBackModelId
        }
        set (value) {
            _mdFeedBackModelId = value
        }
    }
    
    private var _firstName = String()
    open var firstName: String {
        get {
            return _firstName
        }
        set (value) {
            _firstName = value
        }
    }
    
    private var _lastName = String()
    open var lastName: String {
        get {
            return _lastName
        }
        set (value) {
            _lastName = value
        }
    }
    
    private var _text = String()
    open var text: String {
        get {
            return _text
        }
        set (value) {
            _text = value
        }
    }
}
