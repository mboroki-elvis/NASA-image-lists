//
//  BaseTableViewController.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Combine
import SwiftUI
import UIKit

class BaseTableViewController<T: BaseViewModelType>: UIViewController, UITableViewDelegate {
    // MARK: Lifecycle

    /**
       Required to initialize the class with ViewModel of type `T` that conforms to `BaseViewModelType`.
         ### Usage Example: ###
         ````
        init(with: model)
         ````

         * Only ***BaseViewModelType***  is allowed.
     */
    init(with model: T) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    deinit {
        bag.removeAll()
    }

    // MARK: Internal

    var bag = Set<AnyCancellable>()
    @ObservedObject private(set) var model: T
    var showErrorToast: (APIError, @escaping () -> Void) -> Void = { _, _ in }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Theme.backGroundColor
        tableView.estimatedRowHeight = 44
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    /**
      Setting this to `True` will hide the `tableView` and show `activityView`.
     */
    var showActivityView: Bool? {
        didSet {
            guard let show = showActivityView else { return }
            DispatchQueue.main.async {
                self.hideTableView(show)
                self.hideActivity(!show)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func setupViewController() {}

    /**
      This function is used to perform changes whenever the state changes in the ViewModel
         ### Usage Example: ###
         ````
         render(model.state)
         ````

         * Use the `render(:)` function to react to state changes
         * Only ***T.State***  is allowed.
     */
    func render(_ state: T.State) {}

    func showLoadingMore(_ bool: Bool) {
        switch bool {
        case true:
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.startAnimating()
            activityView.translatesAutoresizingMaskIntoConstraints = false
            footerView.addSubview(activityView)
            let contraints = [
                activityView.topAnchor.constraint(equalTo: footerView.topAnchor),
                activityView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
                activityView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
                activityView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            ]
            NSLayoutConstraint.activate(contraints)
            tableFooterView = footerView
        case false:
            tableFooterView = UIView()
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

    // MARK: Private

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.startAnimating()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    private var tableFooterView: UIView? {
        get {
            return tableView.tableFooterView
        }
        set {
            tableView.tableFooterView = newValue
        }
    }

    private func layout() {
        view.backgroundColor = Theme.backGroundColor
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),

            activityIndicatorView.widthAnchor.constraint(equalToConstant: 80),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    private func hideActivity(_ bool: Bool) {
        switch bool {
        case true:
            activityIndicatorView.stopAnimating()
        case false:
            activityIndicatorView.startAnimating()
        }
        activityIndicatorView.isHidden = bool
    }

    private func hideTableView(_ bool: Bool) {
        tableView.isHidden = bool
    }
}
