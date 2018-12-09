//
//  AgencyWithCoverage.swift
//  OBAKit
//
//  Created by Aaron Brethorst on 11/5/18.
//  Copyright © 2018 OneBusAway. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public class AgencyWithCoverage: NSObject, Decodable {
    public let agencyID: String
    public let agency: Agency
    public let region: MKCoordinateRegion

    private enum CodingKeys: String, CodingKey {
        case agencyID = "agencyId"
        case lat, latSpan, lon, lonSpan
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let references = decoder.userInfo[CodingUserInfoKey.references] as! References

        agencyID = try container.decode(String.self, forKey: .agencyID)
        agency = references.agencyWithID(agencyID)!

        let lat = try container.decode(Double.self, forKey: .lat)
        let lon = try container.decode(Double.self, forKey: .lon)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)

        let latSpan = try container.decode(Double.self, forKey: .latSpan)
        let lonSpan = try container.decode(Double.self, forKey: .lonSpan)

        region = MKCoordinateRegion(center: coordinate, latitudinalMeters: latSpan, longitudinalMeters: lonSpan)
    }
}