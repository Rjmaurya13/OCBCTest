//
//  RegisterPresenterTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 30/3/22.
//

import XCTest
@testable import OCBCTest

class RegistrationPresenterTest: XCTestCase {
    var sut: RegistrationPresenter!
    var interacterMock: RegistrationInteractorMock!
    var viewMock:  RegistrationViewMock!
    var routerMock:  RegistrationRouterMock!
    
    override func setUpWithError() throws {
        interacterMock = RegistrationInteractorMock()
        viewMock = RegistrationViewMock()
        routerMock = RegistrationRouterMock()
        sut = RegistrationPresenter(interactor: interacterMock, router: routerMock, view: viewMock)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        interacterMock = nil
        viewMock = nil
        routerMock = nil
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegitrationPresenterMethod() {
        let request = RegistrationRequest(userName: "username", password: "password")
        sut.getRegistration(request: request)
        XCTAssertEqual(interacterMock.callRegistrationApiCounter, 1)
        sut.router?.navigateToDashboard(view: UIViewController())
        XCTAssertEqual(routerMock.navigateToDashboardCounter, 1)        
        
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

final class RegistrationInteractorMock: RegistrationInteractorProtocol {
    var presenter: RegistrationPresenterProtocol?
    private(set) var callRegistrationApiCounter = 0
    func callRegistrationApi(request: RegistrationRequest) {
        callRegistrationApiCounter += 1
    }
}

final class RegistrationViewMock: RegistrationPresenterToViewProtocol {
    var presenter: RegistrationPresenterProtocol?
    private(set) var stopAnimatingCounter = 0
    func stopAnimating() {
        stopAnimatingCounter += 1
    }
}

final class RegistrationRouterMock: RegistrationRouterProtocol {
    private(set) var navigateToDashboardCounter = 0
    func navigateToDashboard(view: UIViewController) {
        navigateToDashboardCounter += 1
    }
}
