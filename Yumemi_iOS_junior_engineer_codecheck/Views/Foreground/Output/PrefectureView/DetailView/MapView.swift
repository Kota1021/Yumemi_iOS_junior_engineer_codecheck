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
    @State private var region:MKCoordinateRegion
    
    let viewSize:CGSize
    
    var mapSize:CGSize{
        let width = viewSize.width
        let height = viewSize.height
        if width < height{
            return CGSize(width: width * 4/5, height: width * 5/5)
        }else{
            return CGSize(width: height * 5/5, height: height * 4/5)
        }
    }
    
    let pinLocation:PinLocation
    
    
    init(isDisplayed: Binding<Bool>,
         viewSize: CGSize,
         pinLocation: PinLocation) {
        
        self._isDisplayed = isDisplayed
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
        self.viewSize = viewSize
        self.pinLocation = pinLocation
        
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
        .transition(.scale(scale: 0,anchor: UnitPoint(x: 0.7, y: 0.7)))
        .frame(width: mapSize.width, height: mapSize.height)
        .background(
            Rectangle()
                .frame(width: viewSize.width, height: viewSize.height)
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation{ isDisplayed = false }
                }
        )
        
    }
}

struct MapView_Previews: PreviewProvider {
    @State static private var isDisplayed = true
    static var previews: some View {
        GeometryReader{ geo in
            MapView(isDisplayed:$isDisplayed, viewSize:geo.size ,pinLocation:  PinLocation(lat: 39, long: 138))
        }}
}


