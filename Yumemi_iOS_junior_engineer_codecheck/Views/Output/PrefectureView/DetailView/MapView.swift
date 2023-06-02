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
    @Binding var isDisplayed: Bool
    let viewSize:CGSize
    let pinLocation:PinLocation
    
    
    @State private var region = MKCoordinateRegion(
        //Mapの中心の緯度経度
        center: CLLocationCoordinate2D(latitude: 38,
                                       longitude: 137),
        //緯度の表示領域(m)
        latitudinalMeters: 1500*1000,
        //経度の表示領域(m)
        longitudinalMeters: 1500*1000
    )
    
    var body: some View {
        Map(coordinateRegion: $region,
            //Mapの操作の指定
            interactionModes: .zoom,
            //現在地の表示
            showsUserLocation: true,
            //現在地の追従
            userTrackingMode: .constant(MapUserTrackingMode.follow),
            annotationItems: [pinLocation]
        ){place in
            MapMarker(coordinate: place.location,
                      tint: Color.orange)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground)))
        .transition(.scale(scale: 0,anchor: UnitPoint(x: 0.7, y: 0.7)))
        .padding(50)
        .background(
            Rectangle()
                .frame(width: viewSize.width, height: viewSize.height)
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation{
                        isDisplayed = false
                    }
                }
        )
        
    }
}

struct MapView_Previews: PreviewProvider {
    @State static private var isDisplayed = true
    static var previews: some View {
        MapView(isDisplayed:$isDisplayed, viewSize:CGSize(width: 300, height: 300),pinLocation:  PinLocation(lat: 39, long: 138))
    }
}


