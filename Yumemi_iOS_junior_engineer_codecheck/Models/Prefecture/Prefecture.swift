//
//  Prefecture.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import Foundation

struct Prefecture{
    //from Yumemi API. In other words, from "LuckyPrefecture"
    let name:String
    let brief:String
    let capital:String
    let citizenDay:MonthDay?
    let hasCoastLine:Bool
    let logoUrl:URL
    
    //from JSON file in bundle
    let location:PinLocation
    
    //from JSON file in bundle and then website "find47"
    let images:[PrefectureImageInfo]
}

extension Prefecture:Equatable{
    static func == (lhs: Prefecture, rhs: Prefecture) -> Bool {
        lhs.name == rhs.name
    }
}



