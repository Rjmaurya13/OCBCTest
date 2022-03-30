//
//  LoginRequest.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
public struct LoginRequest: Codable, Equatable {
    var username: String
    var password: String    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    public var bodyDict: [String: Any] {
        return ["username": username,
                "password": password]
    }
}
