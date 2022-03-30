//
//  LoginRequest.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
public struct RegistrationRequest: Codable, Equatable {
    var userName: String
    var password: String
    public init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    public var bodyDict: [String: Any] {
        return ["username": userName,
                "password": password]
    }
}
