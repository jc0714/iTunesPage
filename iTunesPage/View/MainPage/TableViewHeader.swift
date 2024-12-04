//
//  tableViewHeader.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/4.
//

import Foundation
import UIKit

class TableViewHeader: UIView {

    private let titleLabel = UILabel()
    private let seeMoreButton = UIButton(type: .system)

    init(title: String, buttonTitle: String, section: Int, target: Any, action: Selector) {
        super.init(frame: .zero)
        setupUI(title: title, buttonTitle: buttonTitle, section: section, target: target, action: action)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(title: String, buttonTitle: String, section: Int, target: Any, action: Selector) {
        backgroundColor = .systemBackground

        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        seeMoreButton.setTitle(buttonTitle, for: .normal)
        seeMoreButton.setTitleColor(.darkGray, for: .normal)
        seeMoreButton.tag = section
        seeMoreButton.addTarget(target, action: action, for: .touchUpInside)
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seeMoreButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            seeMoreButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
}
