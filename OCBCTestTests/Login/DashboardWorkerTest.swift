//
//  DashboardWorkerTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 30/3/22.
//

import XCTest
@testable import OCBCTest
class DashboardWorkerTest: XCTestCase {

    var sut: DashboardWorker!
    override func setUpWithError() throws {
        sut = DashboardWorker(networkClient: NetworkClient.shared)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDashBoardWorkerMethod() {
        let request = DashboardRequest(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjQwOWNiMzgwM2Q5Yjk2M2M0NjVlNTUiLCJ1c2VybmFtZSI6InJhamVzaDEiLCJhY2NvdW50Tm8iOiI4MTc2LTI1NS0zMDMyIiwiaWF0IjoxNjQ4NDkzODM2LCJleHAiOjE2NDg1MDQ2MzZ9.LPGYVGIdRv_aSVKFmBmv_QWI4NT_rwHzVAPnQffHVzs")
        let service = DashboardServices.balance(requestPayload: request)
        XCTAssertNotNil(service.path)
        XCTAssertNotNil(service.parameters)
        XCTAssertNotNil(service.baseURL)
        XCTAssertNotNil(service.method)
        sut.callBalanceApi(request: request)
        sut.callTransactionApi(request: request)
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
