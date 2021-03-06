//
//  RecentStopViewModels.swift
//  OBAKit
//
//  Created by Alan Chu on 11/3/20.
//

import OBAKitCore

extension RecentStopsViewController {
    struct StopViewModel: OBAListViewItem {
        let name: String
        let subtitle: String?

        let stopID: String

        var contentConfiguration: OBAContentConfiguration {
            return OBAListRowConfiguration(
                text: name,
                secondaryText: subtitle,
                appearance: .subtitle,
                accessoryType: .disclosureIndicator)
        }

        let onSelectAction: OBAListViewAction<StopViewModel>?
        let onDeleteAction: OBAListViewAction<StopViewModel>?

        init(withStop stop: Stop,
             onSelect selectAction: OBAListViewAction<StopViewModel>?,
             onDelete deleteAction: OBAListViewAction<StopViewModel>?) {
            self.name = stop.name
            self.subtitle = stop.subtitle

            self.stopID = stop.id
            self.onSelectAction = selectAction
            self.onDeleteAction = deleteAction
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(stopID)
        }

        static func == (lhs: StopViewModel, rhs: StopViewModel) -> Bool {
            return lhs.name == rhs.name &&
                lhs.subtitle == rhs.subtitle
        }
    }

    struct AlarmViewModel: OBAListViewItem {
        let alarm: Alarm
        let deepLink: ArrivalDepartureDeepLink

        let title: String

        var contentConfiguration: OBAContentConfiguration {
            return OBAListRowConfiguration(
                text: title,
                appearance: .subtitle,
                accessoryType: .disclosureIndicator)
        }

        let onSelectAction: OBAListViewAction<AlarmViewModel>?
        let onDeleteAction: OBAListViewAction<AlarmViewModel>?

        init?(withAlarm alarm: Alarm,
              onSelect selectAction: OBAListViewAction<AlarmViewModel>?,
              onDelete deleteAction: OBAListViewAction<AlarmViewModel>?) {
            guard let deepLink = alarm.deepLink else { return nil }
            self.alarm = alarm
            self.deepLink = deepLink
            self.title = deepLink.title

            self.onSelectAction = selectAction
            self.onDeleteAction = deleteAction
        }

        func hash(into hasher: inout Hasher) {
            deepLink.hash(into: &hasher)
        }

        static func == (lhs: AlarmViewModel, rhs: AlarmViewModel) -> Bool {
            return lhs.title == rhs.title
        }
    }
}
