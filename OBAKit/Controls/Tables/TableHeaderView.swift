//
//  TableHeaderView.swift
//  OBAKit
//
//  Copyright © Open Transit Software Foundation
//  This source code is licensed under the Apache 2.0 license found in the
//  LICENSE file in the root directory of this source tree.
//

import UIKit
import OBAKitCore

/// A view that approximates the appearance of a UITableView section header.
class TableHeaderView: UIView {
    private let textLabel: UILabel = {
        let label = UILabel.autolayoutNew()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = ThemeColors.shared.secondaryLabel
        return label
    }()

    public var text: String? {
        get {
            textLabel.text
        }
        set {
            if let newValue = newValue {
                textLabel.text = newValue.uppercased()
                textLabel.accessibilityLabel = newValue
            }
            else {
                textLabel.text = nil
                textLabel.accessibilityLabel = nil
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
