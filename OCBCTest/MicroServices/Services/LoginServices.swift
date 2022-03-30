//
//  LoginServices.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
public enum LoginService {
    case login(requestPayload: LoginRequest)
}

extension LoginService:TargetType {
    
    public var baseURL: String {
        return "https://green-thumb-64168.uc.r.appspot.com/"
    }
        
    public var path: URL {
        switch self {
        case .login:
            return URL(string:baseURL + "login")!
        }
    }
    
    public var method: String {
        switch self {
        case .login:
            return "POST"
        }
    }
    public var parameters: [String: Any] {
        switch self {
        case .login(let payload):
            return payload.bodyDict
        }
    }
    public var headers: [String : String]? {
        return [:]
    }
}

public protocol TargetType {

    /// The target's base `URL`.
    var baseURL: String { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: URL { get }

    /// The HTTP method used in the request.
    var method: String { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    var parameters: [String: Any] { get }
}
