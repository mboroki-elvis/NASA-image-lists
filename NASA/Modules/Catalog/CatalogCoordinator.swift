//
//  CatalogCoordinator.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation

final class CatalogCoordinator: BaseCordinator {
    // MARK: Internal

    override func start() {
        let viewModel = CatalogViewModel()
        let controller = CatalogViewController(with: viewModel)
        controller.goToDetails = goToDetails
        controller.showErrorToast = goToError
        push(controller: controller)
    }

    // MARK: Private

    private func goToDetails(_ item: CollectionItem) {
        let coordinator = DetailsCoordinator(coordinator: self, model: item)
        coordinate(to: coordinator)
    }
}
