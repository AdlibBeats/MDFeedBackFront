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
    
    private var _mdFeedBacks = [MDFeedBackModel]()
    open var mdFeedBacks: [MDFeedBackModel] {
        get {
            return _mdFeedBacks
        }
        set (value) {
            _mdFeedBacks = value
        }
    }
    
    private var _mdFeedBack = MDFeedBackModel()
    open var mdFeedBack: MDFeedBackModel {
        get {
            return _mdFeedBack
        }
        set (value) {
            _mdFeedBack = value
        }
    }
    
    private var _isLoaded = false
    open var isLoaded: Bool {
        get {
            return _isLoaded
        }
        set (value) {
            _isLoaded = value
        }
    }
    
    private func log(_ response: DataResponse<Any>?) -> Bool {
        if let httpResponse = response?.response {
            if httpResponse.statusCode != 200 {
                if let data = response?.data {
                    do {
                        let jsonData = try JSON(
                            data: data,
                            options: JSONSerialization
                                .ReadingOptions
                                .mutableLeaves)
                        
                        if let dictionary = jsonData.dictionary {
                            if let message = dictionary["Message"] {
                                print("MD Error: \(message)")
                                return false
                            }
                            else {
                                print("MD Error: Не удалось найти значение по ключу 'Message'")
                                return false
                            }
                        }
                        else {
                            print("MD Error: Словарь json пустой")
                            return false
                        }
                    }
                    catch {
                        print("MD Error: Не удалось сконвертировать полученные данные в формат json")
                        return false
                    }
                }
                else {
                    print("MD Error: Не удалось получить данные с хостинга")
                    return false
                }
            }
            else {
                print("MD Success: Запрос успешно выполнен")
                return true
            }
        }
        else {
            print("MD Error: Не удалось получить данные с хостинга")
            return false
        }
    }
    
    private func getDataRequest(
        _ httpMethod: HTTPMethod,
        _ parameters: Parameters? = nil,
        _ apiUrl: String = "api/MDFeedBacks/") -> DataRequest? {
        
        let parameter = (parameters?["MDFeedBackModelId"] as? Int) ?? 0
        var stringParameter = "\(parameter)"
        if parameter == 0 {
            stringParameter = ""
        }
    
        let url = "\(baseUrl)\(apiUrl)\(stringParameter)"
        isLoaded = false
        switch httpMethod {
        case .get:
            return Alamofire.request(
                url,
                method: httpMethod,
                parameters: nil,
                encoding: JSONEncoding.default,
                headers: nil).responseJSON {
                    response in
                    
                    if parameter == 0 {
                        _ = self.delegate?.getMDFeedBacksLoaded(response)
                    }
                    else {
                        _ = self.delegate?.getMDFeedBackLoaded(response)
                    }
                    self.isLoaded = true
            }
        case .post:
            return Alamofire.request(
                url,
                method: httpMethod,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil).responseJSON {
                    response in
                    
                    _ = self.delegate?.postMDFeedBackLoaded(response)
                    self.isLoaded = true
            }
        case .put:
            return Alamofire.request(
                url,
                method: httpMethod,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil).responseJSON {
                    response in
                    
                    _ = self.delegate?.editMDFeedBackLoaded(response)
                    self.isLoaded = true
            }
        case .delete:
            return Alamofire.request(
                url,
                method: httpMethod,
                parameters: nil,
                encoding: JSONEncoding.default,
                headers: nil).responseJSON {
                    response in
                    
                    _ = self.delegate?.deleteMDFeedBackLoaded(response)
                    self.isLoaded = true
            }
        default:
            return nil
        }
    }
    
    private func getParameters(_ mdFeedBackModel: MDFeedBackModel) -> Parameters {
        return ["MDFeedBackModelId": mdFeedBackModel.mdFeedBackModelId,
                "FirstName": mdFeedBackModel.firstName,
                "LastName": mdFeedBackModel.lastName,
                "Text": mdFeedBackModel.text]
    }
    
    private func getNewMDFeedBackModelFromDictionary(_ dictionary: [String: JSON]) -> MDFeedBackModel {
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
    
    open func getMDFeedBacksLoaded(_ response: DataResponse<Any>?) -> Bool {
        if let data = response?.data {
            do {
                let jsonData = try JSON(
                    data: data,
                    options: JSONSerialization
                        .ReadingOptions
                        .mutableContainers)
                
                if let array = jsonData.array {
                    mdFeedBacks = [MDFeedBackModel]()
                    for item in array {
                        if let dictionary = item.dictionary {
                            let mdFeedBackModel = getNewMDFeedBackModelFromDictionary(dictionary)
                            mdFeedBacks.append(mdFeedBackModel)
                            
                            print("id: \(mdFeedBackModel.mdFeedBackModelId) name: \(mdFeedBackModel.firstName) \(mdFeedBackModel.lastName)\n text: \(mdFeedBackModel.text)")
                        }
                    }
                    return true
                }
                else {
                    print("MD Error: Массив json пустой")
                    return false
                }
            }
            catch {
                print("MD Error: Не удалось сконвертировать полученные данные в формат json")
                return false
            }
        }
        else {
            print("MD Error: Не удалось получить данные с хостинга")
            return false
        }
    }
    
    open func getMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        if let data = response?.data {
            do {
                let jsonData = try JSON(
                    data: data,
                    options: JSONSerialization
                        .ReadingOptions
                        .mutableLeaves)
                
                if let dictionary = jsonData.dictionary {
                    mdFeedBack = getNewMDFeedBackModelFromDictionary(dictionary)
                    
                    print("id: \(mdFeedBack.mdFeedBackModelId) name: \(mdFeedBack.firstName) \(mdFeedBack.lastName)\n text: \(mdFeedBack.text)")
                    
                    return true
                }
                else {
                    print("MD Error: Словарь json пустой")
                    return false
                }
            }
            catch {
                print("MD Error: Не удалось сконвертировать полученные данные в формат json")
                return false
            }
        }
        else {
            print("MD Error: Не удалось получить данные с хостинга")
            return false
        }
    }
    
    open func postMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return log(response)
    }
    
    open func editMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return log(response)
    }
    
    open func deleteMDFeedBackLoaded(_ response: DataResponse<Any>?) -> Bool {
        return log(response)
    }
    
    open func getMDFeedBacks() -> Void {
        _ = getDataRequest(.get)
    }
    
    open func getMDFeedBack(_ mdFeedBackModelId: Int) -> Void {
        _ = getDataRequest(.get, ["MDFeedBackModelId": mdFeedBackModelId])
    }
    
    open func postMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> Void {
        _ = getDataRequest(.post, getParameters(mdFeedBackModel))
    }
    
    open func editMDFeedBack(_ mdFeedBackModel: MDFeedBackModel) -> Void {
        _ = getDataRequest(.put, getParameters(mdFeedBackModel))
    }
    
    open func deleteMDFeedBack(_ mdFeedBackModelId: Int) -> Void {
        _ = getDataRequest(.delete, ["MDFeedBackModelId": mdFeedBackModelId])
    }
}
