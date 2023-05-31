//
//  Output.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Foundation

///prefacture
struct FortuneOutput:Decodable{
    let name:String
    let brief:String
    let capital:String
    let citizenDay:MonthDay?
    let hasCoastLine:Bool
    let logoUrl:URL
}


struct MonthDay:Codable{
    let month:Int
    let day:Int
}

