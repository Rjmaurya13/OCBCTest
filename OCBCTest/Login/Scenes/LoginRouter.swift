//
//  LoginRouter.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation
import UIKit

public class LoginRouter: LoginRouterProtocol {
    public func navigateToDashboard(userName: String, view: UIViewController) {
        let dashboardVc = DashboardConfigurator.shared.createDashboard(userName: userName)
        view.modalPresentationStyle = .fullScreen
        view.navigationController?.pushViewController(dashboardVc, animated: false)
    }
    public func navigateToRegister(view: UIViewController) {
        let dashboardVc = RegistrationConfigurator.shared.createRegisterViewScene()
        view.modalPresentationStyle = .fullScreen
        view.navigationController?.pushViewController(dashboardVc, animated: false)
    }
}
