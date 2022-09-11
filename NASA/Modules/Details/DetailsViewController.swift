//
//  DetailsViewController.swift
//  NASA
//
//  Created by Elvis Mwenda on 11/09/2022.
//

import UIKit

final class DetailsViewController: BaseTableViewController<DetailsViewModel> {
    // MARK: Lifecycle

    override init(with model: DetailsViewModel) {
        super.init(with: model)
        self.model
            .$state
            .sink { [weak self] state in
                self?.render(state)
            }.store(in: &bag)
    }

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatasource()
        setupOutput()
        setupViewController()
    }

    override func setupViewController() {
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: true)
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
    }

    override func render(_ state: DetailsViewModel.State) {
        switch state {
        case .idle:
            showActivityView = true
        case .loaded(let item):
            showActivityView = false
            applySnapshot(data: [item])
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: Private

    private enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>
    private typealias DetailsDatasource = UITableViewDiffableDataSource<Section, CollectionItem>

    private var snapshot = Snapshot()
    private lazy var dataSource: DetailsDatasource = {
        DetailsDatasource(tableView: tableView, cellProvider: { [weak self] _, indexPath, model -> UITableViewCell? in
            guard let self = self else { return nil }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell
            if let source = model.data.first, let link = model.links.first {
                cell?.dataSourceItem = .init(
                    title: source.title,
                    subtitle: "\(source.photographer ?? "") | \(source.formattedDate)",
                    description: source.datumDescription ?? "",
                    link: link.href
                )
            }
            return cell
        })
    }()

    private func setupDatasource() {
        tableView.dataSource = dataSource
    }

    private func setupOutput() {
        model.on(event: .onViewDidLoad)
    }

    private func applySnapshot(with animation: Bool = true, data: [CollectionItem]) {
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animation)
    }
}
