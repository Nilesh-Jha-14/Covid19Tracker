//
//  SessionManager.swift
//  Go-jek-ContactApp
//
//  Created by JHA Nilesh Kumar on 21/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


typealias APIResult = (Bool,Any?,String?) -> ()

enum HTTPMethodType:Int {
    case GET = 1
    case POST = 2
    case PUT = 3
    case DELETE = 4
}

class SessionManager: NSObject {
    
    
    //MARK: - Properties
    
    static var sharedInstance = SessionManager()
    
    private override init() {
        
    }
    //MARK: - Public Methods
 
    public func apiRequest(url:String, method: HTTPMethodType, parameter: [String:Any]?, headers:[String:Any]?, completion:@escaping APIResult) {
        
        var httpMethodValue: HTTPMethod!
        switch method {
        case HTTPMethodType.GET:
            httpMethodValue = HTTPMethod.get
            break
        case HTTPMethodType.POST:
            httpMethodValue = HTTPMethod.post
            break
        case HTTPMethodType.PUT:
            httpMethodValue = HTTPMethod.put
            break
        case HTTPMethodType.DELETE:
            httpMethodValue = HTTPMethod.delete
            break
        }
        AF.request(url,method: httpMethodValue,parameters: parameter,encoding: JSONEncoding.default,headers: nil).responseJSON { (response) in

            switch(response.result) {
            case .success:
                completion(true, response.data, "")
                break
            case .failure:
                completion(false, nil, Message.FetchingDataError)
                return
            }
        }
        
        
    }
    
    
}

