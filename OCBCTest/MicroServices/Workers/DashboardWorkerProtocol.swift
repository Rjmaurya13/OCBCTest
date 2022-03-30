//
//  DashboardWorkerProtocol.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation

public protocol DashboardWorkerProtocol: AnyObject {
    var delegate: DashboardSuccessProtocol? {get set}
    func callBalanceApi(request: DashboardRequest)
    func callTransactionApi(request: DashboardRequest)
}

public protocol DashboardSuccessProtocol {
    func didSuccesRegister(response: DashboardResponse.Balance?)
    func didFailedBalance(error: Error?)
    func didSuccesTransactions(response: DashboardResponse.Transactions?)
    func didFailedTransaction(error: Error?)
}
