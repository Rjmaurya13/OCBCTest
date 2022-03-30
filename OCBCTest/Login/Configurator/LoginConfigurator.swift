//
//  LoginConfigurator.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
import UIKit

public class LoginConfigurator {
    let networkClient = NetworkClient.shared
    public static var shared = LoginConfigurator()
    public func createLoginViewScene() -> UIViewController {
        let view: UIViewController & LoginPresenterToViewProtocol = LoginViewController()       
        let worker: LoginWorkerProtocol = LoginWorker()
        let interactor: LoginInteractorProtocol = LoginInteractor(with: worker)
        let router: LoginRouterProtocol = LoginRouter()
        let presenter: LoginPresenterProtocol = LoginPresenter(interactor: interactor, router: router, view: view)
        view.presenter = presenter
        return view
    }
}
