//
//  MDFeedBackExtension.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 18.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire

extension MessageViewController: MDFeedBackDelegate {
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
}
