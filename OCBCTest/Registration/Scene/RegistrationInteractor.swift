//
//  RegistrationInteractor.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

final class RegistrationInteractor: RegistrationInteractorProtocol {
    private var worker: RegistrationWorkerProtocol?
    weak var presenter: RegistrationPresenterProtocol?
    init(with worker: RegistrationWorkerProtocol) {
        self.worker = worker
        self.worker?.delegate = self
    }
    func callRegistrationApi(request: RegistrationRequest) {
        worker?.callRegistrationApi(request: request)
    }
}

extension RegistrationInteractor: RegistrationSuccessProtocol {
    func didSuccesRegister(response: RegistrationResponse?) {
        presenter?.registerSuccess(response: response)
    }    
    func didFailedRegister(erros: Error?) {
        presenter?.registerFailed(error: erros)
    }
}
