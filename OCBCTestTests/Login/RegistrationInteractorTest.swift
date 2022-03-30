//
//  RegisterInteractorTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 30/3/22.
//

import XCTest
@testable import OCBCTest
class RegistrationInteractorTest: XCTestCase {
    var sut: RegistrationInteractor!
    var presenterMock:  RegistrationPresenterMock!
    var workerMock:  RegistrationWorkerMock!

    override func setUpWithError() throws {
        workerMock = RegistrationWorkerMock()
        presenterMock = RegistrationPresenterMock()
        sut = RegistrationInteractor(with: workerMock)
        sut.presenter = presenterMock
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        workerMock = nil
        sut = nil
        presenterMock = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegistrationInteractorMethod() {
        let request = RegistrationRequest(userName: "username", password: "password")
        sut.callRegistrationApi(request: request)
        XCTAssertEqual(workerMock.callRegistrationApiCounter, 1)
        sut.didFailedRegister(erros: nil)
        XCTAssertEqual(presenterMock.registerFailedCounter, 1)
        sut.didSuccesRegister(response: RegistrationResponse(status: "success", token: "12121", error: nil))
        XCTAssertEqual(presenterMock.registerSuccessCounter,1)
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

final class RegistrationPresenterMock: RegistrationPresenterProtocol {
    
    var interactor: RegistrationInteractorProtocol?
    
    var view: RegistrationPresenterToViewProtocol?
    
    var router: RegistrationRouterProtocol?
    private(set) var registerSuccessCounter = 0
    private(set) var registerFailedCounter = 0
    private(set) var getRegistrationCounter = 0
    func registerSuccess(response: RegistrationResponse?) {
        registerSuccessCounter += 1
    }
    func registerFailed(error: Error?) {
        registerFailedCounter += 1
    }
    func getRegistration(request: RegistrationRequest) {
        getRegistrationCounter += 1
    }
}

final class RegistrationWorkerMock: RegistrationWorkerProtocol {
    private(set) var callRegistrationApiCounter = 0
    func callRegistrationApi(request: RegistrationRequest) {
        callRegistrationApiCounter += 1
    }
    var delegate: RegistrationSuccessProtocol?
}
