//
//  RegistrationRouter.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation
import UIKit

public class RegistrationRouter: RegistrationRouterProtocol {
    public func navigateToDashboard(view: UIViewController) {
        let dashboardVc = DashboardConfigurator.shared.createDashboard(userName: OCBCHelper.shared.userName ?? "")
        view.modalPresentationStyle = .fullScreen
        view.navigationController?.pushViewController(dashboardVc, animated: false)
    }
}
