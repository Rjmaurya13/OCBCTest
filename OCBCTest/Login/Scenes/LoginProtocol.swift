//
//  LoginProtocol.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
import UIKit

public protocol LoginPresenterProtocol: AnyObject {
    var interactor: LoginInteractorProtocol? {get set}
    var view: LoginPresenterToViewProtocol? {get set}
    var router: LoginRouterProtocol? {get set}
    func getLogin(request: LoginRequest)
    func goToRegister()
}
public protocol LoginInteractorProtocol: AnyObject {
    var worker: LoginWorkerProtocol? {get set}
    init(with worker: LoginWorkerProtocol)
    func callLoginApi(request: LoginRequest)
    var presenter: LoginInteractorToPresenterProtocol? {get set}
}
public protocol LoginPresenterToViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? {get set}
    func stopAnimating()
    func onRegisterTap()
}
public protocol LoginInteractorToPresenterProtocol: AnyObject {
    func loginSuccess(response: LoginResponse?)
    func loginFailed(error: Error?)
}
public protocol LoginRouterProtocol: AnyObject {
    func navigateToDashboard(userName: String, view: UIViewController)
    func navigateToRegister(view: UIViewController)
}
