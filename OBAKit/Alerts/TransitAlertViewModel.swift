//
//  TransitAlertViewModel.swift
//  OBAKit
//
//  Created by Alan Chu on 1/16/21.
//

import OBAKitCore
import Foundation

struct TransitAlertDataListViewModel: OBAListViewItem {
    let transitAlert: TransitAlertViewModel

    let id: String
    let title: String
    let body: String
    let localizedURL: URL?

    /// Truncated summary for UILabel performance. Agencies often provide long
    /// summaries, which causes poor UI performance for us. See #264 & #266.
    var subtitle: String { return String(body.prefix(256)) }
    var onSelectAction: OBAListViewAction<TransitAlertDataListViewModel>?

    var contentConfiguration: OBAContentConfiguration {
        var config = OBAListRowConfiguration(
            text: title,
            secondaryText: subtitle,
            appearance: .subtitle,
            accessoryType: .disclosureIndicator)

        config.image = Icons.readAlert.applyingSymbolConfiguration(.init(textStyle: .body))
        config.textConfig.numberOfLines = 2
        config.secondaryTextConfig.numberOfLines = 3

        config.textConfig.accessibilityNumberOfLines = 5
        config.secondaryTextConfig.accessibilityNumberOfLines = 8
        return config
    }

    init(_ transitAlert: TransitAlertViewModel, forLocale locale: Locale, onSelectAction: OBAListViewAction<TransitAlertDataListViewModel>? = nil) {
        self.transitAlert = transitAlert
        self.id = transitAlert.id
        self.title = transitAlert.title(forLocale: locale) ?? ""
        self.body = transitAlert.body(forLocale: locale) ?? ""
        self.localizedURL = transitAlert.url(forLocale: locale)
        self.onSelectAction = onSelectAction
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TransitAlertDataListViewModel, rhs: TransitAlertDataListViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.body == rhs.body &&
            lhs.localizedURL == rhs.localizedURL
    }
}
