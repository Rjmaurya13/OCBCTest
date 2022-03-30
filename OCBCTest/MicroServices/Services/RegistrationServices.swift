//
//  RegistrationServices.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation

public enum RegistrationServices {
    case registration(requestPayload: RegistrationRequest)
}

extension RegistrationServices:TargetType {
    
    public var baseURL: String {
        return "https://green-thumb-64168.uc.r.appspot.com/"
    }
        
    public var path: URL {
        switch self {
        case .registration:
            return URL(string:baseURL + "register")!
        }
    }
    
    public var method: String {
        switch self {
        case .registration:
            return "POST"
        }
    }
    public var parameters: [String: Any] {
        switch self {
        case .registration(let payload):
            return payload.bodyDict
        }
    }
    public var headers: [String : String]? {
        return [:]
    }
}
