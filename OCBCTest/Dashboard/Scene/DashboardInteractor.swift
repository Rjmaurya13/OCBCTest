//
//  DashboardInteractor.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

final class DashboardInteractor: DashboardInteractorProtocol {
    private var worker: DashboardWorkerProtocol?
    weak var presenter: DashboardPresenterProtocol?
    init(with worker: DashboardWorkerProtocol) {
        self.worker = worker
        self.worker?.delegate = self
    }
    func getBalance(request: DashboardRequest) {
        worker?.callBalanceApi(request: request)
    }
    func getTransactions(request: DashboardRequest) {
        worker?.callTransactionApi(request: request)
    }
}

extension DashboardInteractor: DashboardSuccessProtocol {
    func didSuccesRegister(response: DashboardResponse.Balance?) {
        presenter?.didSuccessBalance(response: response)
    }    
    func didFailedBalance(error: Error?) {
        presenter?.didFailedBalance(error: error)
    }
    func didSuccesTransactions(response: DashboardResponse.Transactions?) {
        presenter?.didSuccesTransactions(response: response)
    }
    func didFailedTransaction(error: Error?) {
        presenter?.didFailedTransaction(error: error)
    }
}
