//
//  LoginResponse.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

public struct LoginResponse: Codable {
    var status: String?
    var token: String?
    var username: String?
    var accountNo: String?
    var error: String?
}
