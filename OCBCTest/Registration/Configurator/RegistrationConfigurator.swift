//
//  RegistrationConfigurator.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
import UIKit

public class RegistrationConfigurator {
    let networkClient = NetworkClient.shared
    public static var shared = RegistrationConfigurator()
    public func createRegisterViewScene() -> UIViewController {
        let view: UIViewController & RegistrationPresenterToViewProtocol = RegistrationViewController()
        
        let worker: RegistrationWorkerProtocol = RegistrationWorker()
        let interactor: RegistrationInteractorProtocol = RegistrationInteractor(with: worker)
        let router: RegistrationRouterProtocol = RegistrationRouter()
        let presenter: RegistrationPresenterProtocol = RegistrationPresenter(interactor: interactor, router: router, view: view)
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        return view
    }
}
