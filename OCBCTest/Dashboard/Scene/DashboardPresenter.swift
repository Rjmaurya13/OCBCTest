//
//  DashboardPresentor.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

final class DashboardPresenter: DashboardPresenterProtocol {
    var interactor: DashboardInteractorProtocol?
    var view: DashboardPresenterToViewProtocol?
    var router: DashboardRouterProtocol?
    var balanceModel: DashboardResponse.Balance?
    var transactionModel: DashboardResponse.Transactions?
    init(interactor: DashboardInteractorProtocol,
         router: DashboardRouterProtocol,
         view: DashboardPresenterToViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
        interactor.presenter = self
    }
    func getBalance(request: DashboardRequest) {
        interactor?.getBalance(request: request)
    }
    func getTransaction(request: DashboardRequest) {
        interactor?.getTransactions(request: request)
    }
}

extension DashboardPresenter {
    func didSuccessBalance(response: DashboardResponse.Balance?) {
        self.balanceModel = response
        view?.reloadData()
    }
    func didFailedBalance(error: Error?) {
        view?.stopAnimating()
    }
    func didSuccesTransactions(response: DashboardResponse.Transactions?) {
        self.transactionModel = response
        view?.reloadData()
    }
    func didFailedTransaction(error: Error?) {
        view?.stopAnimating()
    }
}
