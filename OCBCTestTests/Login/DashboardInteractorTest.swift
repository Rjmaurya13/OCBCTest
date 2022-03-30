//
//  DashboardInteractorTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 29/3/22.
//

import XCTest
@testable import OCBCTest

class DashboardInteractorTest: XCTestCase {
    var sut: DashboardInteractor!    
    var presenterMock:  DashboardPresenterMock!
    var workerMock:  DashboardWorkerMock!
    var worker:  DashboardWorker!
    var successMock: DashboardSuccessMock!
    override func setUpWithError() throws {
        presenterMock =  DashboardPresenterMock()
        worker = DashboardWorker()
        workerMock = DashboardWorkerMock()
        successMock = DashboardSuccessMock()
        workerMock.delegate = successMock
        sut = DashboardInteractor(with: workerMock)
        sut.presenter = presenterMock
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        presenterMock =  nil
        workerMock = nil
        sut = nil
        successMock = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDashboardInteractorMethod() {
        let request = DashboardRequest(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjQwOWNiMzgwM2Q5Yjk2M2M0NjVlNTUiLCJ1c2VybmFtZSI6InJhamVzaDEiLCJhY2NvdW50Tm8iOiI4MTc2LTI1NS0zMDMyIiwiaWF0IjoxNjQ4NDkzODM2LCJleHAiOjE2NDg1MDQ2MzZ9.LPGYVGIdRv_aSVKFmBmv_QWI4NT_rwHzVAPnQffHVzs")
        sut.getBalance(request: request)
        XCTAssertEqual(workerMock.didCallBalanceApiCounter, 1)
        sut.getTransactions(request: request)
        XCTAssertEqual(workerMock.didCallTransactionApiCounter, 1)
        
        let balanceReponse = DashboardResponse.Balance(status: "success", balance: 10000, accountNo: "12121212", error: "")
        workerMock.delegate?.didSuccesRegister(response: balanceReponse)
                        
        let sender = DashboardResponse.Sender(accountNo: "Jhon", accountHolder: "121212")
        let data = DashboardResponse.Data.init(transactionId: "1212121", amount: 1000, transactionDate: "29 Dec 2021", description: "", transactionType: "", sender: sender)
        let transaction = DashboardResponse.Transactions(status: "success", data: [data])
        workerMock.delegate?.didSuccesTransactions(response: transaction)
        
        sut.didFailedBalance(error: nil)
        sut.didFailedTransaction(error: nil)
        XCTAssertTrue(presenterMock.didFailedBalanceCounter)
        XCTAssertTrue(presenterMock.didFailedTransactionCounter)
        
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
final class DashboardPresenterMock: DashboardPresenterProtocol {
    var interactor: DashboardInteractorProtocol?
    var view: DashboardPresenterToViewProtocol?
    var router: DashboardRouterProtocol?
    var balanceModel: DashboardResponse.Balance?
    var transactionModel: DashboardResponse.Transactions?
    private(set) var didGetTransactionCounter = Int.zero
    private(set) var didGetBalanceCounter = Int.zero
    
    func getTransaction(request: DashboardRequest) {
        didGetTransactionCounter += 1
    }
    func getBalance(request: DashboardRequest) {
        didGetBalanceCounter += 1
    }
    private(set) var didSuccessBalanceCounter = Int.zero
    private(set) var didFailedBalanceCounter = false
    private(set) var didSuccesTransactionsCounter = Int.zero
    private(set) var didFailedTransactionCounter = false

    func didSuccessBalance(response: DashboardResponse.Balance?) {
        didSuccessBalanceCounter += 1
    }

    func didFailedBalance(error: Error?) {
        didFailedBalanceCounter =  true
    }

    func didSuccesTransactions(response: DashboardResponse.Transactions?) {
        didSuccesTransactionsCounter += 1
    }

    func didFailedTransaction(error: Error?) {
        didFailedTransactionCounter = true
    }
}

final class DashboardWorkerMock: DashboardWorkerProtocol {
    var delegate: DashboardSuccessProtocol?
    private(set) var didCallBalanceApiCounter = Int.zero
    private(set) var didCallTransactionApiCounter = Int.zero
    func callBalanceApi(request: DashboardRequest) {
        didCallBalanceApiCounter += 1
    }
    func callTransactionApi(request: DashboardRequest) {
        didCallTransactionApiCounter += 1
    }
}

final class DashboardSuccessMock: DashboardSuccessProtocol {
    private(set) var didSuccesRegisterCounter = Int.zero
    private(set) var didFailedBalanceCounterNew = Int.zero
    private(set) var didSuccesTransactionsCounter = Int.zero
    private(set) var didFailedTransactionCounter = Int.zero
    
    func didSuccesRegister(response: DashboardResponse.Balance?) {
        didSuccesRegisterCounter += 1
    }
    func didFailedBalance(error: Error?) {
        didFailedBalanceCounterNew += 1
    }
    func didSuccesTransactions(response: DashboardResponse.Transactions?) {
        didSuccesTransactionsCounter += 1
    }
    func didFailedTransaction(error: Error?) {
        didFailedTransactionCounter += 1
    }
}
