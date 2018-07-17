//
//  MDFeedBackDelegate.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire

protocol MDFeedBackDelegate {
    func getMDFeedBacksLoaded(_ response: DataResponse<Any>?)
    func getMDFeedBackLoaded(_ response: DataResponse<Any>?)
    func postMDFeedBackLoaded(_ response: DataResponse<Any>?)
    func editMDFeedBackLoaded(_ response: DataResponse<Any>?)
    func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?)
}
