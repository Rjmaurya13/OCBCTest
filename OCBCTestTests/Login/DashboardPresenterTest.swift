//
//  DashboardPresenterTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 29/3/22.
//

import XCTest
@testable import OCBCTest
class DashboardPresenterTest: XCTestCase {

    var sut: DashboardPresenter!
    var interacterMock: DashboardInteractorMock!
    var viewMock:  DashboardViewMock!
    var routerMock:  DashboardRouterMock!
//    var getBalanceMockDelegate: DashboardInteractorToPresenterMock!
    
    override func setUpWithError() throws {
        interacterMock = DashboardInteractorMock()
        viewMock = DashboardViewMock()
        routerMock = DashboardRouterMock()
//        getBalanceMockDelegate = DashboardInteractorToPresenterMock()
//        interacterMock.getBalanceDelegate = getBalanceMockDelegate
        
        sut = DashboardPresenter(interactor: interacterMock, router: routerMock, view: viewMock)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        interacterMock = nil        
        viewMock = nil
        routerMock = nil
//        getBalanceMockDelegate = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDashBoardMethods() {
        let request = DashboardRequest(token: "token")
        sut.getBalance(request: request)
        XCTAssertEqual(interacterMock.didGetBalanceCounter, 1)
        
        sut.getTransaction(request: request)
        XCTAssertEqual(interacterMock.didGetTransactionsCounter, 1)        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

final class DashboardInteractorMock: DashboardInteractorProtocol {
    private(set) var didGetBalanceCounter = Int.zero
    private(set) var didGetTransactionsCounter = Int.zero
    var presenter: DashboardPresenterProtocol?

    func getBalance(request: DashboardRequest) {
        didGetBalanceCounter += 1
    }
    
    func getTransactions(request: DashboardRequest) {
        didGetTransactionsCounter += 1
    }
}
final class DashboardViewMock: DashboardPresenterToViewProtocol {
    var presenter: DashboardPresenterProtocol?
    var userName: String?
    private(set) var didReloadDataCounter = Int.zero
    private(set) var stopAnimatingCounter = Int.zero
    func reloadData() {
        didReloadDataCounter += 1
    }
    func stopAnimating() {
        stopAnimatingCounter += 1
    }
}

final class DashboardRouterMock: DashboardRouterProtocol {
    
}
