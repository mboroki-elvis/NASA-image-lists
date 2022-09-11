//
//  DetailsCoordinator.swift
//  NASA
//
//  Created by Elvis Mwenda on 11/09/2022.
//

import Foundation

final class DetailsCoordinator: BaseCordinator {
    // MARK: Lifecycle

    convenience init(coordinator: Coordinator, model: CollectionItem) {
        self.init(with: coordinator)
        self.model = model
    }

    // MARK: Internal

    override func start() {
        guard let model = model else { return }
        let viewModel = DetailsViewModel(model: model)
        let controller = DetailsViewController(with: viewModel)
        push(controller: controller)
    }

    // MARK: Private

    private var model: CollectionItem?
}
