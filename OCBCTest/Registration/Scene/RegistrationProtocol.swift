//
//  RegistrationProtocol.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
import UIKit

public protocol RegistrationPresenterProtocol: AnyObject {
    func getRegistration(request: RegistrationRequest)
    var interactor: RegistrationInteractorProtocol? {get set}
    var view: RegistrationPresenterToViewProtocol? {get set}
    var router: RegistrationRouterProtocol? {get set}
    func registerSuccess(response: RegistrationResponse?)
    func registerFailed(error: Error?)
}

public protocol RegistrationInteractorProtocol: AnyObject {
    func callRegistrationApi(request: RegistrationRequest)
    var presenter: RegistrationPresenterProtocol? {get set}
}
public protocol RegistrationPresenterToViewProtocol: AnyObject {
    var presenter: RegistrationPresenterProtocol? {get set}
    func stopAnimating()
}
public protocol RegistrationRouterProtocol: AnyObject {
    func navigateToDashboard(view: UIViewController)
}
