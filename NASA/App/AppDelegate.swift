//
//  AppDelegate.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Theme.default.apply()
        let controller = UINavigationController()
        let coordinator = AppCoordinator(
            window: UIWindow(frame: UIScreen.main.bounds),
            navigationController: controller
        )
        coordinator.start()
        return true
    }
}

