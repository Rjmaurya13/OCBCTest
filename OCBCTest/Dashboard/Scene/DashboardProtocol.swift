//
//  DashboardProtocol.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
import UIKit

public protocol DashboardPresenterProtocol: AnyObject {
    func getBalance(request: DashboardRequest)
    var interactor: DashboardInteractorProtocol? {get set}
    var view: DashboardPresenterToViewProtocol? {get set}
    var router: DashboardRouterProtocol? {get set}
    var balanceModel: DashboardResponse.Balance? {get set}
    var transactionModel: DashboardResponse.Transactions? {get set}
    func getTransaction(request: DashboardRequest)
    func didSuccessBalance(response: DashboardResponse.Balance?)
    func didFailedBalance(error: Error?)
    func didSuccesTransactions(response: DashboardResponse.Transactions?)
    func didFailedTransaction(error: Error?)
}

public protocol DashboardInteractorProtocol: AnyObject {
    func getBalance(request: DashboardRequest)
    func getTransactions(request: DashboardRequest)
    var presenter: DashboardPresenterProtocol? {get set}
}
public protocol DashboardPresenterToViewProtocol: AnyObject {
    var userName: String?  {get set}
    var presenter: DashboardPresenterProtocol? {get set}
    func reloadData()
    func stopAnimating()
}
public protocol DashboardRouterProtocol: AnyObject {
    
}
