//
//  MDFeedBackDelegate.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

protocol MDFeedBackProtocol {
    func getMDFeedBacks() -> Void
    func getMDFeedBack(_ idMDFeedBackModel: Int) -> Void
    func getLastMDFeedBack() -> Void
    func getFirstMDFeedBack() -> Void
    func postMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> Void
    func editMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> Void
    func deleteMDFeedBack(_ idMDFeedBackModel: Int) -> Void
}
