//
//  MDFeedBackDelegate.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire

protocol MDFeedBackDelegate {
    func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) -> Bool
    func getMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool
    func postMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool
    func editMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool
    func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool
}
