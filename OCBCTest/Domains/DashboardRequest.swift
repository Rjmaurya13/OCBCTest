//
//  LoginRequest.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
public struct DashboardRequest: Codable, Equatable {
    var token: String
    
    public init(token: String) {
        self.token = token
    }
    public var bodyDict: [String: Any] {
        return [:]
    }
}
