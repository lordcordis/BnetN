//
//  Networking.swift
//  BnetN
//
//  Created by Роман on 20.05.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import Alamofire



class Networking {
    
    
    static func newSession(completion:  @escaping ((Result<Data, Error>)->())) {
        let parameters = NetworkingCore.createParameters(method: .new, body: nil, id: nil)
        NetworkingCore.performRequestWithResult(parameters: parameters, completion: completion)
    }
        
    static func getEntriesResult(completion:  @escaping ((Result<Data, Error>)->())) {
        let parameters = NetworkingCore.createParameters(method: .get, body: nil, id: nil)
        NetworkingCore.performRequestWithResult(parameters: parameters, completion: completion)
    }
    
    
    static func addEntryAF(text: String, completion:  @escaping ([Entry])->()) {
        let parameters = NetworkingCore.createParameters(method: .add, body: text, id: nil)
        NetworkingCore.performRequestWithAF(parameters: parameters, completion: completion)
    }
    
//    static func editEntryAF(text: String, id: String, completion:  @escaping ([Entry])->()) {
//        let parameters = NetworkingCore.createParameters(method: .edit, body: text, id: id)
//        NetworkingCore.performRequestWithAF(parameters: parameters, completion: completion)
//    }
    
    static func removeEntryAF(id: String, completion:  @escaping ([Entry])->()) {
        
        let parameters = NetworkingCore.createParameters(method: .remove, body: nil, id: id)
        NetworkingCore.performRequestWithAF(parameters: parameters, completion: completion)
    }
    
    
    
    
    
    
}


//func SessionIdKey() -> String {
//
//    var resultString = "kik"
//
//    let parameters =["a" : "new_session"]
//    NetworkingCore.performRequestWithResult(parameters: parameters) { (result) in
//
//
//
//        switch result {
//        case .success(let dataRetrieved):
//            print(String(data: dataRetrieved, encoding: .utf8))
//            guard let decoded = try? NetworkingCore.jsondec.decode(SingleResponseSession.self, from: dataRetrieved) else {return}
//            print(decoded.data.session)
//            resultString = decoded.data.session
//
//
//        case .failure(let errorR):
//            print(errorR.localizedDescription)
//        }
//
//}
//
//    return resultString
//}


func retrieveNewSessionKey(completion: @escaping (String?)->()) {
    
    var resultString: String?
    
    let parameters = ["a" : "new_session"]
    NetworkingCore.performRequestWithResult(parameters: parameters) { (result) in
        
        
        
        switch result {
        case .success(let dataRetrieved):
            print(String(data: dataRetrieved, encoding: .utf8))
            guard let decoded = try? NetworkingCore.jsonDecoder.decode(SingleResponseSession.self, from: dataRetrieved) else {return}
            print("\(decoded.data.session) decoded.data.session")
            resultString = decoded.data.session
            completion(resultString)
            
            
        case .failure(let errorR):
            print(errorR.localizedDescription)
            completion(nil)
        }
        
    }
}
