//
//  ImageCell.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation
import UIKit

final class CatalogCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = Theme.backGroundColor
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        let contraints = [
            contentImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            contentImageView.widthAnchor.constraint(equalToConstant: 64),
            contentImageView.heightAnchor.constraint(equalToConstant: 64),
            contentImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: subLabel.topAnchor),
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var dataSourceItem: UIModel? {
        didSet {
            if let source = dataSourceItem {
                titleLabel.text = source.title
                subLabel.text = source.subtitle
                if  let url = URL(string: source.link) {
                    contentImageView.load(url: url, placeholder: nil)
                }
            }
        }
    }

    // MARK: Private

    private let contentImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension CatalogCell {
    struct UIModel {
        let title: String
        let subtitle: String
        let link: String
    }
}
