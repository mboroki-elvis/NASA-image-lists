//
//  Coordinator.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: Coordinator? { get set }
    var parentCoordinator: Coordinator? { get set }
    var navigationContoller: UINavigationController? { get set }
    func start()
    func coordinate(to coordinator: Coordinator)
    init(navigationController: UINavigationController?)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
