//
//  NetworkingCore.swift
//  BnetN
//
//  Created by Роман on 22.05.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingCore {
    
    static let headers: HTTPHeaders = ["token" : "rmk5zfN-Zg-XoE3sbs"]
    static let apiUrlString = "https://bnet.i-partner.ru/testAPI/"
//    static var sessionId = "yEmo1pMJMbtjbGsBjQ"
    
    static var sessionId: String {
        return UserDefaults.standard.string(forKey: "key")!
    }

        
            
        
        
    
    
    static let jsonDecoder = JSONDecoder()
    //    static let authKey = "firstLaunchKeyString"
    //    static let firstLaunchKeyBool = "firstLaunchKeyBool"
    
    static func createParameters (method: ApiMethod, body: String?, id: String?) -> ([String: String]) {
        
        var result: [String: String] = [:]
        
        switch method {
        case .new:
            result = ["a" : "\(ApiMethod.get.rawValue)"]
            
        case .get:
            result = ["a" : "\(ApiMethod.get.rawValue)",
                "session" : NetworkingCore.sessionId]
            
        case .add:
            if let body = body {
                result = ["a" : "\(ApiMethod.add.rawValue)",
                    "session" : NetworkingCore.sessionId,
                    "body" : body]
            }
            
        case .edit:
            if let id = id, let body = body {
                result = ["a" : "\(ApiMethod.edit.rawValue)",
                    "session" : NetworkingCore.sessionId,
                    "body" : body,
                    "id" : id]
            }
            
        case .remove:
            if let id = id {
                result = ["a" : "\(ApiMethod.remove.rawValue)",
                    "session" : NetworkingCore.sessionId,
                    "id" : id]
            }
        }
        return result
    }
    
//    static func getKeyForAuthentication() -> String? {
//
//        var keyForAuth = ""
//
//        Networking.newSession { result in
//            switch result {
//            case .success(let data):
//                if let entryWithKey = try? NetworkingCore.jsonDecoder.decode(SingleResponseSession.self, from: data) {
//                    let key = entryWithKey.data.session
//                    keyForAuth = key
//                }
//            case .failure(_):
//                print("first launch procedure failure")
//            }
//        }
//
//        return keyForAuth
//    }
    
    
    static func performRequestWithAF (parameters: [String: String], completion: @escaping ([Entry])->()) {
        
        AF.request(apiUrlString, method: .post, parameters: parameters, headers: NetworkingCore.headers).response {
            
            (res) in
            
            print(#function)
            
            guard let res = res.data, let text = String(data: res, encoding: .utf8), let result = try? jsonDecoder.decode(SingleResponse.self, from: res), let export = result.data?.first else {return}
            
            print(text)
            completion(export)
        }
    }
    
    
    func firstLaunchCheck() {
        
        
    }
    
    func firstLaunch () {
        
    }
    
    
    
    static func dataToEntry(res: Data) -> [Entry]? {
        
        guard let data = try? NetworkingCore.jsonDecoder.decode(SingleResponse.self, from: res), let resultingEntryArray = data.data?.first else {return nil}
        return resultingEntryArray
        
    }
    
    static func performRequestWithResult (parameters: [String: String], completion: @escaping ((Result<Data, Error>)->())) {
        
        AF.request(apiUrlString, method: .post, parameters: parameters, headers: NetworkingCore.headers).response {
            
            (res) in
            
            switch res.result {
                
            case .success(let data):
                if let data = data {
                    completion(Result.success(data))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
