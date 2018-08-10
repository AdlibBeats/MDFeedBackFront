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
    open var messages = [String]()
    
    init() {
        baseUrl = "http://proarttherapy.ru/"
        delegate = nil
        initError()
    }
    
    init(_ baseUrl: String) {
        self.baseUrl = baseUrl
        delegate = nil
        initError()
    }
    
    init(_ baseUrl: String, _ delegate: MDFeedBackDelegate?) {
        self.baseUrl = baseUrl
        self.delegate = delegate
        initError()
    }
    
    init(_ delegate: MDFeedBackDelegate?) {
        baseUrl = "http://proarttherapy.ru/"
        self.delegate = delegate
        initError()
    }
    
    private func initError() -> Void {
        messages = [
            "MD Error (\(type(of: self))): Не удалось получить данные с хостинга.",
            "MD Error (\(type(of: self))): Не удалось сконвертировать полученные данные в формат json.",
            "MD Error (\(type(of: self))): Словарь json пустой.",
            "MD Error (\(type(of: self))): Массив json пустой.",
            "MD Error (\(type(of: self))): Не удалось найти значение по ключу: ",
            "MD Success (\(type(of: self))): Запрос успешно выполнен."
        ]
    }
    
    private func printMessage(responseData: Data?) -> Void {
        guard let responseData = responseData else {
            print(messages[0])
            return
        }
        guard let jsonData = getJsonData(
            responseData,
            JSONSerialization.ReadingOptions.mutableLeaves) else {
                print(messages[1])
                return
        }
        guard let jsonDictionary = jsonData.dictionary else {
            print(messages[2])
            return
        }
        
        let keyMessage = "Message"
        guard let message = jsonDictionary[keyMessage] else {
            print(messages[4] + "'\(keyMessage)'.")
            return
        }
        print("MD Error: \(message)")
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
            print("MD Exception: \(error)")
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
            print(messages[0])
            return false
        }
        if httpResponse.statusCode != 200 {
            printMessage(responseData: response?.data)
            return false
        }
        guard let responseData = response?.data else {
            print(messages[0])
            return false
        }
        guard let jsonData = getJsonData(
            responseData,
            JSONSerialization.ReadingOptions.mutableContainers) else {
                print(messages[1])
                return false
        }
        guard let jsonArray = jsonData.array else {
            print(messages[3])
            return false
        }
        mdFeedBacks = [MDFeedBackModel]()
        for jsonItem in jsonArray {
            guard let jsonDictionary = jsonItem.dictionary else { continue }
            let mdFeedBackModel = getModel(jsonDictionary)
            mdFeedBacks.append(mdFeedBackModel)
            printModel(mdFeedBackModel)
        }
        print(messages[5])
        
        return true
    }
    
    open func getMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(messages[0])
            return false
        }
        if httpResponse.statusCode != 200 {
            printMessage(responseData: response?.data)
            return false
        }
        guard let responseData = response?.data else {
            print(messages[0])
            return false
        }
        guard let jsonData = getJsonData(
            responseData,
            JSONSerialization.ReadingOptions.mutableLeaves) else {
                print(messages[1])
                return false
        }
        guard let jsonDictionary = jsonData.dictionary else {
            print(messages[2])
            return false
        }
        mdFeedBack = getModel(jsonDictionary)
        printModel(mdFeedBack)
        print(messages[5])
        
        return true
    }
    
    open func postMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(messages[0])
            return false
        }
        
        if httpResponse.statusCode == 200 {
            print(messages[5])
            return true
        }
        printMessage(responseData: response?.data)
        
        return false
    }
    
    open func editMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(messages[0])
            return false
        }
        
        if httpResponse.statusCode == 200 {
            print(messages[5])
            return true
        }
        printMessage(responseData: response?.data)
        
        return false
    }
    
    open func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        guard let httpResponse = response?.response else {
            print(messages[0])
            return false
        }
        
        if httpResponse.statusCode == 200 {
            print(messages[5])
            return true
        }
        printMessage(responseData: response?.data)
        
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
