//
//  LoginResponse.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

public struct DashboardResponse: Codable {
    public struct Balance: Codable {
        var status: String?
        var balance: Float = 0
        var accountNo: String?
        var error: String?
    }
    public struct Transactions: Codable {
        var status: String?
        var data: [Data]
    }
    public struct Data: Codable {
        var transactionId: String?
        var amount: Float = 0
        var transactionDate: String?
        var description: String?
        var transactionType: String?
        var sender: Sender?
    }
    public struct Sender: Codable {
        var accountNo: String?
        var accountHolder: String?
    }
}
