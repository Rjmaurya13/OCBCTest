//
//  DashboardConfigurator.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation
import UIKit

public class DashboardConfigurator {
    let networkClient = NetworkClient.shared
    public static var shared = DashboardConfigurator()
    public func createDashboard(userName: String) -> UIViewController {
        let view: UIViewController & DashboardPresenterToViewProtocol = DashboardViewController()
        
        let worker: DashboardWorkerProtocol = DashboardWorker()
        let interactor: DashboardInteractorProtocol = DashboardInteractor(with: worker)
        let router: DashboardRouterProtocol = DashboardRouter()
        let presenter: DashboardPresenterProtocol = DashboardPresenter(interactor: interactor, router: router, view: view)
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        view.userName = userName
        return view
    }
}
