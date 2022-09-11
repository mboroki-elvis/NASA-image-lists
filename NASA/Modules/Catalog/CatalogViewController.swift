//
//  CatalogViewController.swift
//  NASA
//
//  Created by Elvis Mwenda on 30/05/2022.
//

import UIKit

final class CatalogViewController: BaseTableViewController<CatalogViewModel> {
    // MARK: Lifecycle

    override init(with model: CatalogViewModel) {
        super.init(with: model)
        self.model
            .$state
            .sink { [weak self] state in
                self?.render(state)
            }.store(in: &bag)
    }

    // MARK: Internal

    var goToDetails: (CollectionItem) -> Void = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutput()
        setupDatasource()
        setupViewController()
    }

    override func setupViewController() {
        title = "The Milky Way"
        tableView.separatorStyle = .none
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(CatalogCell.self, forCellReuseIdentifier: CatalogCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }

    override func render(_ state: CatalogViewModel.State) {
        if let response = state.response {
            showActivityView = false
            showLoadingMore(state.showMoreLoader)
            applySnapshot(data: response.collection.items)
        } else {
            showActivityView = state.isLoading
        }
        if let error = state.error {
            showErrorToast(error) { [unowned self] in
                self.model.on(event: .onLoadNext)
            }
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfSections = tableView.numberOfSections
        guard indexPath.section == (numberOfSections - 1) else { return }
        let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
        guard indexPath.row == numberOfRows - 1 else { return }
        model.on(event: .onLoadNext)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let response = model.state.response?.collection.items[indexPath.item] else { return }
        goToDetails(response)
    }

    // MARK: Private

    private enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>
    private typealias PostDatasource = UITableViewDiffableDataSource<Section, CollectionItem>

    private var snapshot = Snapshot()
    private lazy var dataSource: PostDatasource = {
        PostDatasource(tableView: tableView, cellProvider: { [weak self] _, indexPath, model -> UITableViewCell? in
            guard let self = self else { return nil }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: CatalogCell.identifier, for: indexPath) as? CatalogCell
            if let source = model.data.first, let link = model.links.first {
                cell?.dataSourceItem = .init(
                    title: source.title,
                    subtitle: "\(source.photographer ?? "") | \(source.formattedDate)",
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
