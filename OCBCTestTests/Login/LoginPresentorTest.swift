//
//  LoginPresentorTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 29/3/22.
//

import XCTest
@testable import OCBCTest

class LoginPresentorTest: XCTestCase {
    var subject: LoginPresenter!
    var router: LoginRouterProtocol!
    var interactor: LoginInteractorMock!
    var view: LoginViewMockData!
    var model: LoginResponse!
    var worker: LoginWorkerMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        router = LoginRouter()
        view = LoginViewMockData()
        worker = LoginWorkerMock()
        interactor = LoginInteractorMock(with: worker)
        subject = LoginPresenter(interactor: interactor, router: router, view: view)
    }

    override func tearDownWithError() throws {
        subject = nil
        router = nil
        interactor = nil
        view = nil
        try super.tearDownWithError()
    }

    func testPresentPosts() {
        // Given
        subject.interactor = interactor
        subject.view = view
        // When
        let request = LoginRequest.init(username: "abc@gmail.com", password: "31123123123")
        subject.getLogin(request: request)
        // Then
        XCTAssertEqual(interactor.displayPostCalled, true)
        let presenter = LoginInteractorToPresenterMock()
        interactor?.presenter = presenter
        subject.router = router
        let response = LoginResponse.init(status: "Success", token: "werewerwerw", username: "abc", accountNo: "234234234", error: "")
        presenter.loginSuccess(response: response)
        XCTAssertEqual((presenter.didSuccessCounter != 0), true)
        let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid access token"])
        presenter.loginFailed(error: error)
        XCTAssertEqual((presenter.didFailedCounter != 0), true)
        subject.router?.navigateToRegister(view: RegistrationConfigurator.shared.createRegisterViewScene())        
    }
}
// MARK: Test doubles
class LoginInteractorMock: LoginInteractorProtocol {
    var presenter: LoginInteractorToPresenterProtocol?
    var displayPostCalled = false
    var worker: LoginWorkerProtocol?
    required init(with worker: LoginWorkerProtocol) {
        self.worker = worker
    }
    func callLoginApi(request: LoginRequest) {
        displayPostCalled = true
    }
}
class LoginInteractorToPresenterMock: LoginInteractorToPresenterProtocol {
    private(set) var didSuccessCounter = Int.zero
    private(set) var didFailedCounter = Int.zero
    func loginSuccess(response: LoginResponse?) {
        didSuccessCounter += 1
    }
    
    func loginFailed(error: Error?) {
        didFailedCounter += 1
    }
}
class LoginViewMockData: LoginPresenterToViewProtocol {
    var presenter: LoginPresenterProtocol?
    private(set) var didStopAnimationCounter = 0
    private(set) var didRegisterTapCounter = 0
    func stopAnimating() {
        didStopAnimationCounter += 1
    }
    func onRegisterTap() {
        didRegisterTapCounter += 1
    }
}

class LoginWorkerMock: LoginWorkerProtocol {
    var delegate: LoginSuccessProtocol?
    private(set) var didLoginApiCounter = 0
    func callLoginApi(request: LoginRequest) {
        didLoginApiCounter += 1
    }
}
