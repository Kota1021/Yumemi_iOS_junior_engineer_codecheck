//
//  PrefecturePositions.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import Foundation
fileprivate struct PrefectureLocation: Decodable {
    let prefecture:String
    let latitude:Double
    let longitude:Double
}

struct PrefectureLocations{
    
    private let data:[PrefectureLocation] = load("prefLatiLong.json")
    
    func location(of prefecture:String)->PinLocation{
        
        guard let prefLocation = data.first(where: {$0.prefecture == prefecture} )else {
            fatalError("no position data for prefecture: \(prefecture)") }
        
        return PinLocation(lat: prefLocation.latitude, long: prefLocation.longitude)
    }
}


