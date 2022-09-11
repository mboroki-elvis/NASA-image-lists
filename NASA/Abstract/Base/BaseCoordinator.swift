//
//  BaseCordinator.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import UIKit

class BaseCordinator: Coordinator {
    // MARK: Lifecycle

    required init(navigationController: UINavigationController?) {
        self.navigationContoller = navigationController
    }

    convenience init(with coordinator: Coordinator) {
        self.init(navigationController: coordinator.navigationContoller)
        self.childCoordinator = self
        self.parentCoordinator = coordinator
    }

    // MARK: Internal

    var parentCoordinator: Coordinator?
    weak var childCoordinator: Coordinator?
    var navigationContoller: UINavigationController?

    func start() {}
    func push(controller: UIViewController) {
        navigationContoller?.pushViewController(controller, animated: true)
    }

    func present(controller: UIViewController) {
        navigationContoller?.present(controller, animated: true)
    }
    
    func goToError(error: APIError, completion: @escaping () -> Void) {
        let controller = UIAlertController(
            title: nil,
            message: error.userFriendlyMessage,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: error.canRetry ? "Retry" : "Ok", style: .default) { _ in
            guard error.canRetry else { return }
            completion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        controller.addAction(action)
        controller.addAction(cancel)
        present(controller: controller)
    }
}
