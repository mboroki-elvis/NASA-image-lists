//
//  DetailsDescriptionCell.swift
//  NASA
//
//  Created by Elvis Mwenda on 11/09/2022.
//

import UIKit
final class DetailsCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(descriptionLabel)
        let contraints = [
            contentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentImageView.heightAnchor.constraint(equalToConstant: 230),
            contentImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -24),

            titleLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: subLabel.topAnchor, constant: -8),

            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
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
                descriptionLabel.text = source.description
                descriptionLabel.setLineSpacing(lineSpacing: 10.0)
                if let url = URL(string: source.link) {
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

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension DetailsCell {
    struct UIModel {
        let title: String
        let subtitle: String
        let description: String
        let link: String
    }
}
