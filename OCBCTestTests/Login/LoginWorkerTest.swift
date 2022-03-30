//
//  LoginWorkerTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 29/3/22.
//

import XCTest
@testable import OCBCTest

class LoginWorkerTest: XCTestCase {
    var subject: LoginWorker!
    let networkClient: NetworkClient = NetworkClient.shared
    var loginSucessDelegate = LoginPresenterResponseMockData()
    override func setUpWithError() throws {
        try super.setUpWithError()
        subject = LoginWorker.init(networkClient: networkClient)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        subject = nil
        try super.tearDownWithError()
    }
    
    func testAPICall() {
        let request = LoginRequest.init(username: "abc@gmail.com", password: "31123123123")
        subject.delegate = loginSucessDelegate
        let expectations = expectation(description: "The Response result match the expected results")
        subject?.callLoginApi(request: request)
        expectations.fulfill()
        waitForExpectations(timeout: 20, handler: { (error) in
            if let error = error {
                XCTAssertNil(error, "The api request does not fullfill the expectaion")
            }
        })
        let response = LoginResponse.init(status: "Success", token: "werewerwerw", username: "abc", accountNo: "234234234", error: "")
        loginSucessDelegate.didSuccesLogin(response: response)
        XCTAssertEqual((loginSucessDelegate.didSuccessCounter != 0), true)
        let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid access token"])
        loginSucessDelegate.didFailedLogin(error: error)
        XCTAssertEqual((loginSucessDelegate.didFailedCounter != 0), true)
    }
}
