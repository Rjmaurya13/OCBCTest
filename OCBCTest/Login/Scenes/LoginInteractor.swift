//
//  LoginInteractor.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

final class LoginInteractor: LoginInteractorProtocol {
    var worker: LoginWorkerProtocol?
    weak var presenter: LoginInteractorToPresenterProtocol?
    init(with worker: LoginWorkerProtocol) {
        self.worker = worker
        self.worker?.delegate = self
    }
    func callLoginApi(request: LoginRequest) {
        worker?.callLoginApi(request: request)
    }
}

extension LoginInteractor: LoginSuccessProtocol {
    func didSuccesLogin(response: LoginResponse?) {
        presenter?.loginSuccess(response: response)
    }
    
    func didFailedLogin(error: Error?) {
        presenter?.loginFailed(error: error)
    }
}
