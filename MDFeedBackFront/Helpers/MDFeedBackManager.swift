//
//  MDFeedBackManager.swift
//  MDFeedBackFront
//
//  Created by Андрей Васильев on 17.07.2018.
//  Copyright © 2018 Андрей Васильев. All rights reserved.
//

import Alamofire
import SwiftyJSON

open class MDFeedBackManager : MDFeedBackProtocol, MDFeedBackDelegate {
    
    var delegate: MDFeedBackDelegate?
    open let baseUrl: String
    open let apiUrl: String = "api/MDFeedBacks/"
    open var mdFeedBacks = [MDFeedBackModel]()
    open var mdFeedBack = MDFeedBackModel()
    open var isLoaded = true
    open var errorsDictionary =
        [
            1: "MD Error: Не удалось получить данные с хостинга.",
            2: "MD Error: Не удалось сконвертировать полученные данные в формат json.",
            3: "MD Error: Словарь json пустой.",
            4: "MD Error: Массив json пустой.",
            5: "MD Error: Не удалось найти значение по ключу 'Message'.",
            6: "MD Success: Запрос успешно выполнен."
        ]
    
    init() {
        self.baseUrl = "http://proarttherapy.ru/"
        self.delegate = nil
    }
    
    init(_ baseUrl: String) {
        self.baseUrl = baseUrl
        self.delegate = nil
    }
    
    init(_ baseUrl: String, _ delegate: MDFeedBackDelegate?) {
        self.baseUrl = baseUrl
        self.delegate = delegate
    }
    
    init(_ delegate: MDFeedBackDelegate?) {
        self.baseUrl = "http://proarttherapy.ru/"
        self.delegate = delegate
    }
    
    private func printError(responseData: Data?) -> Void {
        guard let responseData = responseData else {
            print(errorsDictionary[1]!)
            return
        }
        guard let jsonData = getJsonData(
            responseData,
            JSONSerialization.ReadingOptions.mutableLeaves) else {
                print(errorsDictionary[2]!)
                return
        }
        guard let jsonDictionary = jsonData.dictionary else {
            print(errorsDictionary[3]!)
            return
        }
        guard let errorMessage = jsonDictionary["Message"] else {
            print(errorsDictionary[5]!)
            return
        }
        print("MD Error: \(errorMessage)")
    }
    
    private func getDataRequest(
        _ httpMethod: HTTPMethod,
        _ field: String? = nil,
        _ parameters: Parameters? = nil,
        _ action: ((_ response: DataResponse<Any>?) -> Bool)? = nil) -> DataRequest? {
        
        let url = "\(baseUrl)\(apiUrl)\(field ?? "")"
        isLoaded = false
        
        return Alamofire.request(
            url,
            method: httpMethod,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON {
                response in

                _ = action?(response)
                self.isLoaded = true
        }
    }
    
    private func getJsonData(
        _ data: Data,
        _ options: JSONSerialization.ReadingOptions = []) -> JSON? {
        
        do {
            let jsonData = try JSON(
                data: data,
                options: options)
            return jsonData
        }
        catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    private func getParameters(_ mdFeedBackModel: MDFeedBackModel) -> Parameters {
        return ["MDFeedBackModelId": mdFeedBackModel.mdFeedBackModelId,
                "FirstName": mdFeedBackModel.firstName,
                "LastName": mdFeedBackModel.lastName,
                "Text": mdFeedBackModel.text]
    }
    
    private func getModel(_ dictionary: [String: JSON]) -> MDFeedBackModel {
        
        let mdFeedBackModel = MDFeedBackModel()
        if let mdFeedBackModelId = dictionary["MDFeedBackModelId"]?.int {
            mdFeedBackModel.mdFeedBackModelId = mdFeedBackModelId
        }
        
        if let firstName = dictionary["FirstName"]?.string {
            mdFeedBackModel.firstName = firstName
        }
        
        if let lastName = dictionary["LastName"]?.string {
            mdFeedBackModel.lastName = lastName
        }
        
        if let text = dictionary["Text"]?.string {
            mdFeedBackModel.text = text
        }
        
        return mdFeedBackModel
    }
    
    private func printModel(_ mdFeedBackModel: MDFeedBackModel) -> Void {
        print("id:\(mdFeedBackModel.mdFeedBackModelId)\n firstName:\(mdFeedBackModel.firstName) lastName:\(mdFeedBackModel.lastName)\n text:\(mdFeedBackModel.text)")
    }
    
    open func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(errorsDictionary[1]!)
            return false
        }
        if httpResponse.statusCode != 200 {
            printError(responseData: response?.data)
            return false
        }
        guard let responseData = response?.data else {
            print(errorsDictionary[1]!)
            return false
        }
        guard let jsonData = getJsonData(
            responseData,
            JSONSerialization.ReadingOptions.mutableContainers) else {
                print(errorsDictionary[2]!)
                return false
        }
        guard let jsonArray = jsonData.array else {
            print(errorsDictionary[4]!)
            return false
        }
        
        mdFeedBacks = [MDFeedBackModel]()
        for jsonItem in jsonArray {
            guard let jsonDictionary = jsonItem.dictionary else { continue }
            
            let mdFeedBackModel = getModel(jsonDictionary)
            mdFeedBacks.append(mdFeedBackModel)
            printModel(mdFeedBackModel)
        }
        print(errorsDictionary[6]!)
        
        return true
    }
    
    open func getMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(errorsDictionary[1]!)
            return false
        }
        if httpResponse.statusCode != 200 {
            printError(responseData: response?.data)
            return false
        }
        guard let responseData = response?.data else {
            print(errorsDictionary[1]!)
            return false
        }
        guard let jsonData = getJsonData(
            responseData,
            JSONSerialization.ReadingOptions.mutableLeaves) else {
                print(errorsDictionary[2]!)
                return false
        }
        guard let jsonDictionary = jsonData.dictionary else {
            print(errorsDictionary[3]!)
            return false
        }
        
        mdFeedBack = getModel(jsonDictionary)
        printModel(mdFeedBack)
        print(errorsDictionary[6]!)
        
        return true
    }
    
    open func postMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(errorsDictionary[1]!)
            return false
        }
        
        if httpResponse.statusCode == 200 {
            print(errorsDictionary[6]!)
            return true
        }
        printError(responseData: response?.data)
        
        return false
    }
    
    open func editMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(errorsDictionary[1]!)
            return false
        }
        
        if httpResponse.statusCode == 200 {
            print(errorsDictionary[6]!)
            return true
        }
        printError(responseData: response?.data)
        
        return false
    }
    
    open func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(errorsDictionary[1]!)
            return false
        }
        
        if httpResponse.statusCode == 200 {
            print(errorsDictionary[6]!)
            return true
        }
        printError(responseData: response?.data)
        
        return false
    }
    
    open func getMDFeedBacks() -> DataRequest? {
        return getDataRequest(
            .get,
            nil,
            nil,
            self.delegate?.getMDFeedBacksLoaded)
    }
    
    open func getMDFeedBack(_ mdFeedBackModelId: Int) -> DataRequest? {
        return getDataRequest(
            .get,
            "\(mdFeedBackModelId)",
            nil,
            self.delegate?.getMDFeedBackLoaded)
    }
    
    open func getLastMDFeedBack() -> DataRequest? {
        return getDataRequest(
            .get,
            "Last",
            nil,
            self.delegate?.getMDFeedBackLoaded)
    }
    
    open func getFirstMDFeedBack() -> DataRequest? {
        return getDataRequest(
            .get,
            "First",
            nil,
            self.delegate?.getMDFeedBackLoaded)
    }
    
    open func postMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> DataRequest? {
        return getDataRequest(
            .post,
            nil,
            getParameters(mdFeedBackModel),
            self.delegate?.postMDFeedBackLoaded)
    }
    
    open func editMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> DataRequest? {
        return getDataRequest(
            .put,
            "\(mdFeedBackModel.mdFeedBackModelId)",
            getParameters(mdFeedBackModel),
            self.delegate?.editMDFeedBackLoaded)
    }
    
    open func deleteMDFeedBack(_ mdFeedBackModelId: Int) -> DataRequest? {
        return getDataRequest(
            .delete,
            "\(mdFeedBackModelId)",
            nil,
            self.delegate?.deleteMDFeedBackLoaded)
    }
}
