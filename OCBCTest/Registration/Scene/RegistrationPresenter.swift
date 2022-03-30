//
//  RegistrationPresentor.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation
import UIKit

final class RegistrationPresenter: RegistrationPresenterProtocol {
    var interactor: RegistrationInteractorProtocol?
    var view: RegistrationPresenterToViewProtocol?
    var router: RegistrationRouterProtocol?
    init(interactor: RegistrationInteractorProtocol,
         router: RegistrationRouterProtocol,
         view: RegistrationPresenterToViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
        interactor.presenter = self
    }
    func getRegistration(request: RegistrationRequest) {
        interactor?.callRegistrationApi(request: request)
    }
}

extension RegistrationPresenter {
    func registerSuccess(response: RegistrationResponse?) {
        if let token = response?.token {
            OCBCHelper.shared.token = token
        } else {
            guard let view = self.view as? UIViewController else { return}
            view.showToast(message: response?.error ?? "Failed. Try with different user name.", seconds: 4)
        }
        guard let view = self.view as? UIViewController & RegistrationPresenterToViewProtocol else {return}
        DispatchQueue.main.async { [weak self] in
            view.stopAnimating()
            self?.router?.navigateToDashboard(view: view)            
        }
    }
    func registerFailed(error: Error?) {
        DispatchQueue.main.async {
            self.view?.stopAnimating()
            guard let view = self.view as? UIViewController else { return}
            view.showToast(message: error.debugDescription, seconds: 4)
        }
    }
}
