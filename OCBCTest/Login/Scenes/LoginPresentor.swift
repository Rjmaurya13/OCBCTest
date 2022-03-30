//
//  LoginPresentor.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation
import UIKit

final class LoginPresenter: LoginPresenterProtocol {
    var interactor: LoginInteractorProtocol?
    var view: LoginPresenterToViewProtocol?
    var router: LoginRouterProtocol?
    init(interactor: LoginInteractorProtocol,
         router: LoginRouterProtocol,
         view: LoginPresenterToViewProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
        interactor.presenter = self
    }
    func getLogin(request: LoginRequest) {
        interactor?.callLoginApi(request: request)
    }
    func goToRegister() {
        guard let view = view as? UIViewController else {return}
        self.router?.navigateToRegister(view: view)
    }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    func loginSuccess(response: LoginResponse?) {
        if let token = response?.token {
            OCBCHelper.shared.token = token
        }
        guard let view = view as? UIViewController else {return}
        DispatchQueue.main.async {
            self.view?.stopAnimating()
            self.router?.navigateToDashboard(userName: response?.username ?? "", view: view)
        }
    }
    func loginFailed(error: Error?) {
        view?.stopAnimating()
    }
}
