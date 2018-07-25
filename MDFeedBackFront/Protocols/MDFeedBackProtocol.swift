//
//  MDFeedBackDelegate.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire

protocol MDFeedBackProtocol {
    func getMDFeedBacks() -> DataRequest?
    func getMDFeedBack(_ idMDFeedBackModel: Int) -> DataRequest?
    func getLastMDFeedBack() -> DataRequest?
    func getFirstMDFeedBack() -> DataRequest?
    func postMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> DataRequest?
    func editMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> DataRequest?
    func deleteMDFeedBack(_ idMDFeedBackModel: Int) -> DataRequest?
}
