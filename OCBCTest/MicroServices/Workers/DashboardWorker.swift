//
//  DashboardWorker.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation

public class DashboardWorker: DashboardWorkerProtocol {
    private let networkClient: NetworkClient
    public var delegate: DashboardSuccessProtocol?
    public init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    public func callBalanceApi(request: DashboardRequest) {
        networkClient.requestObject(service: DashboardServices.balance(requestPayload: request), C: DashboardResponse.Balance.self) { [weak self] (result, error) in
            if result != nil {
                self?.delegate?.didSuccesRegister(response: result)
            } else {
                self?.delegate?.didFailedBalance(error: error)
            }
        }
    }
    public func callTransactionApi(request: DashboardRequest) {
        networkClient.requestObject(service: DashboardServices.transaction(requestPayload: request), C: DashboardResponse.Transactions.self) { [weak self] (result, error) in
            if result != nil {
                self?.delegate?.didSuccesTransactions(response: result)
            } else {                
                self?.delegate?.didFailedTransaction(error: error)
            }
        }
    }
}
