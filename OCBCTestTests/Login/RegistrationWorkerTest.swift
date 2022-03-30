//
//  RegisterMockTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 30/3/22.
//

import XCTest
@testable import OCBCTest

class RegistrationWorkerTest: XCTestCase {
    var sut: RegistrationWorker!

    override func setUpWithError() throws {
        sut = RegistrationWorker(networkClient: NetworkClient.shared)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRegistrationWorkerMethod() {
        let request = RegistrationRequest(userName: "username", password: "password")
        let service = RegistrationServices.registration(requestPayload: request)
        XCTAssertNotNil(service.method)
        XCTAssertNotNil(service.path)
        XCTAssertNotNil(service.baseURL)
        sut.callRegistrationApi(request: request)
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
