//
//  AppCoordinator.swift
//  NASA
//
//  Created by Elvis Mwenda on 04/06/2022.
//

import UIKit

final class AppCoordinator: BaseCordinator {
    // MARK: Lifecycle

    convenience init(window: UIWindow?, navigationController: UINavigationController) {
        self.init(navigationController: navigationController)
        self.window = window
        if #available(iOS 13.0, *) {
            navigationController.overrideUserInterfaceStyle = .light
        }
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }

    // MARK: Internal

    override func start() {
        let coordinator = CatalogCoordinator(with: self)
        coordinate(to: coordinator)
    }

    // MARK: Private

    private var window: UIWindow!
}
