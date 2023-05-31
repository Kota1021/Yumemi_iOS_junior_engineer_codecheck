//
//  Input.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Foundation

struct FortuneInput:Encodable{
    let name:String // no more than 127 characters
    let birthday:YearMonthDay
    let bloodType:ABOBloodType
    let today:YearMonthDay
    
    var isValid:Bool{ !name.isEmpty && name.count < 128 }

}

struct YearMonthDay:Codable{
    let year:Int
    let month:Int
    let day:Int
}

// Now only considering ABO blood group. not RH etc...
enum ABOBloodType:String,Codable{
    case a = "a"
    case b = "b"
    case ab = "ab"
    case o = "o"
}
