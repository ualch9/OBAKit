//
//  BookmarksViewModel.swift
//  OBAKit
//
//  Created by Alan Chu on 11/25/20.
//

import Foundation
import OBAKitCore

struct BookmarkArrivalContentConfiguration: OBAContentConfiguration {
    var viewModel: BookmarkArrivalViewModel
    var formatters: Formatters?

    var obaContentView: (OBAContentView & ReuseIdentifierProviding).Type {
        return TripBookmarkTableCell.self
    }
}

/// Used by `OBAListView` to display bookmark data in `BookmarksViewController`.
struct BookmarkArrivalViewModel: OBAListViewItem {
    let bookmark: Bookmark

    // MARK: - View model properties
    let bookmarkID: UUID
    let name: String
    let regionIdentifier: Int
    let stopID: StopID

    let isFavorite: Bool
    let sortOrder: Int

    let routeShortName: String?
    let tripHeadsign: String?
    let routeID: RouteID?

    // TODO: Same as mentioned above, make arrival departures a struct.
    let arrivalDepartures: [ArrivalDeparture]?

    static var customCellType: OBAListViewCell.Type? {
        return TripBookmarkTableCell.self
    }

    var contentConfiguration: OBAContentConfiguration {
        return BookmarkArrivalContentConfiguration(viewModel: self)
    }

    var onSelectAction: OBAListViewAction<BookmarkArrivalViewModel>?
    var onDeleteAction: OBAListViewAction<BookmarkArrivalViewModel>?

    init(bookmark: Bookmark,
         arrivalDepartures: [ArrivalDeparture]?,
         onSelect: OBAListViewAction<BookmarkArrivalViewModel>?) {
        self.bookmark = bookmark
        self.bookmarkID = bookmark.id
        self.name = bookmark.name
        self.regionIdentifier = bookmark.regionIdentifier
        self.stopID = bookmark.stopID

        self.isFavorite = bookmark.isFavorite
        self.sortOrder = bookmark.sortOrder
        self.routeShortName = bookmark.routeShortName
        self.tripHeadsign = bookmark.tripHeadsign
        self.routeID = bookmark.routeID

        self.arrivalDepartures = arrivalDepartures

        self.onSelectAction = onSelect
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(bookmarkID)
        hasher.combine(regionIdentifier)
        hasher.combine(stopID)
    }

    static func == (lhs: BookmarkArrivalViewModel, rhs: BookmarkArrivalViewModel) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.sortOrder == rhs.sortOrder &&
            lhs.routeShortName == rhs.routeShortName &&
            lhs.tripHeadsign == rhs.tripHeadsign &&
            lhs.routeID == rhs.routeID &&
            lhs.arrivalDepartures == rhs.arrivalDepartures
    }
}
