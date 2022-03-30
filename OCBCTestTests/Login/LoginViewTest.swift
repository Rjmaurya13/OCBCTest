//
//  LoginViewTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 30/3/22.
//

import XCTest
@testable import OCBCTest

class LoginViewTest: XCTestCase {
    var view: LoginViewController?
    var presenterMock: LoginPresenterMock!
    
    override func setUpWithError() throws {
        presenterMock = LoginPresenterMock()
        guard let loginView = LoginConfigurator.shared.createLoginViewScene() as? LoginViewController else { return }
        view = loginView
        view?.presenter = presenterMock
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        view = nil
        presenterMock = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginViewMethod() {
        XCTAssertTrue(((view?.isViewLoaded) != nil))
        
        view?.onRegisterTap()
        XCTAssertEqual(presenterMock.goToRegisterCounter, 1)
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

final class LoginPresenterMock: LoginPresenterProtocol {
    var interactor: LoginInteractorProtocol?
    var view: LoginPresenterToViewProtocol?
    var router: LoginRouterProtocol?
    private(set) var getLoginCounter = Int.zero
    private(set) var goToRegisterCounter = Int.zero
    func getLogin(request: LoginRequest) {
        getLoginCounter += 1
    }
    func goToRegister() {
        goToRegisterCounter += 1
    }
}
