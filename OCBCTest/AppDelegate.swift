//
//  AppDelegate.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rootViewController = LoginConfigurator.shared.createLoginViewScene()
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.isNavigationBarHidden = true
        window = UIWindow()
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }
}

