//
//  LoginServices.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
public enum DashboardServices {
    case balance(requestPayload: DashboardRequest)
    case transaction(requestPayload: DashboardRequest)
}

extension DashboardServices:TargetType {
    
    public var baseURL: String {
        return "https://green-thumb-64168.uc.r.appspot.com/"
    }        
    public var path: URL {
        switch self {
        case .balance:
            return URL(string:baseURL + "balance")!
        case .transaction:
            return URL(string:baseURL + "transactions")!
        }
    }
    public var method: String {
        switch self {
        case .balance, .transaction:
            return "GET"
        }
    }
    public var parameters: [String: Any] {
        switch self {
        case .balance, .transaction:
            return [:]
        }
    }
    public var headers: [String : String]? {
        switch self {
        case .balance, .transaction:
            return ["Authorization": OCBCHelper.shared.token ?? ""]
        }
    }
}
