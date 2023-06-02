//
//  MapView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//
//cf.https://zenn.dev/ryo_dev/articles/f7a016b8f46092

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(
        //Mapの中心の緯度経度
        center: CLLocationCoordinate2D(latitude: 38,
                                       longitude: 137),
        //緯度の表示領域(m)
        latitudinalMeters: 1500*1000,
        //経度の表示領域(m)
        longitudinalMeters: 1500*1000
    )
    
    private let place = [IdentifiablePlace(lat: 38, long: 137),
                 IdentifiablePlace(lat: 39, long: 138)]
    
    var body: some View {
        Map(coordinateRegion: $region,
               //Mapの操作の指定
               interactionModes: .zoom,
               //現在地の表示
               showsUserLocation: true,
               //現在地の追従
               userTrackingMode: .constant(MapUserTrackingMode.follow),
            annotationItems: place
        ){place in
                   MapMarker(coordinate: place.location,
                             tint: Color.orange)
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

fileprivate struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
