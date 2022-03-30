//
//  LoginInteractorTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 29/3/22.
//

import XCTest
@testable import OCBCTest

class LoginInteractorTest: XCTestCase {
    // MARK: Subject under test
    var subject: LoginInteractor!
    var worker: LoginWorkerMockData!
    var presenter: LoginPresenterMock!
    var loginSucessDelegate = LoginPresenterResponseMockData()
    override func setUpWithError() throws {
        try super.setUpWithError()
        testSetupInteractor()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        subject = nil
        worker = nil
        try super.tearDownWithError()
    }
    // MARK: Test setup
    func testSetupInteractor() {
        worker = LoginWorkerMockData()
        worker.delegate = loginSucessDelegate
        presenter =  LoginPresenterMock()
        subject = LoginInteractor(with: worker)
//        subject.presenter = presenter
    }
    // MARK: Tests
    func testFetchPosts() {
        let request = LoginRequest.init(username: "abc@gmail.com", password: "31123123123")
        subject.callLoginApi(request: request)
        XCTAssertTrue(worker.displayPostCalled, "FetchPosts() should ask the presenter to present the post")
        let response = LoginResponse.init(status: "Success", token: "werewerwerw", username: "abc", accountNo: "234234234", error: "")
        loginSucessDelegate.didSuccesLogin(response: response)
        XCTAssertEqual((loginSucessDelegate.didSuccessCounter != 0), true)
        let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid access token"])
        loginSucessDelegate.didFailedLogin(error: error)
        XCTAssertEqual((loginSucessDelegate.didFailedCounter != 0), true)
    }
}
class LoginPresenterResponseMockData: LoginSuccessProtocol{
    private(set) var didSuccessCounter = 0
    private(set) var didFailedCounter = 0
    func didSuccesLogin(response: LoginResponse?) {
        didSuccessCounter += 1
    }
    
    func didFailedLogin(error: Error?) {
        didFailedCounter += 1
    }
    
}
public class LoginWorkerMockData: LoginWorkerProtocol {    
    public var delegate: LoginSuccessProtocol?
    public var displayPostCalled = false
    public func callLoginApi(request: LoginRequest) {
        displayPostCalled = true
    }
}
