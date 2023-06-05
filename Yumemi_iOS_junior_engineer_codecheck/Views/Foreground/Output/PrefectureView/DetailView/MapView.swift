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
    @State private var region:MKCoordinateRegion
    let pinLocation:PinLocation
    
    init(pinLocation: PinLocation) {
        self.pinLocation = pinLocation
        
        self._region = State(initialValue:
            MKCoordinateRegion(
            //Mapの中心の緯度経度
            center: CLLocationCoordinate2D(latitude: pinLocation.location.latitude,
                                           longitude: pinLocation.location.longitude),
            //緯度の表示領域(m)
            latitudinalMeters: 1500*1000,
            //経度の表示領域(m)
            longitudinalMeters: 1500*1000
        ) )
    }
    
    var body: some View {
        Map(coordinateRegion: $region,
            //Mapの操作の指定
            interactionModes: .all,
            showsUserLocation: false,
            annotationItems: [pinLocation]
        ){ place in
            MapMarker(coordinate: place.location,
                      tint: Color.orange)
        }
        .padding(10)
        .background(Color(.secondarySystemBackground) )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct MapView_Previews: PreviewProvider {
    @State static private var isDisplayed = true
    static var previews: some View {
        GeometryReader{ geo in
            MapView(/*isDisplayed:$isDisplayed, backgroundSize:geo.size ,*/pinLocation:  PinLocation(lat: 39, long: 138))
        }}
}


