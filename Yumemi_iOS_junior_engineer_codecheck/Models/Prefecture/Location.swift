//
//  PrefecturePositions.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import Foundation
import MapKit

///location infomation from JSON file in Bundle
struct PrefectureLocations {

    private init() {}  // Singleton like. No need for initializing this data holding struct.
    private static let data: [PrefectureLocation] = load("prefLatiLong.json")

    static func location(of prefecture: String) -> PinLocation {
        guard let prefLocation = data.first(where: { $0.prefecture == prefecture }) else {
            fatalError("no location data for prefecture: \(prefecture)")

        }

        return PinLocation(lat: prefLocation.latitude, long: prefLocation.longitude)
    }

    private struct PrefectureLocation: Decodable {
        let prefecture: String
        let latitude: Double
        let longitude: Double
    }
}

struct PinLocation: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
