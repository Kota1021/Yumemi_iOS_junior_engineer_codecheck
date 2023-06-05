//
//  Input.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Foundation
import SwiftyUserDefaults

struct FetchInput:Codable{
    public let name:String // no more than 127 characters
    public let birthday:YearMonthDay
    public let bloodType:ABOBloodType
    public let today:YearMonthDay
    
    public var fetchedAt:Date{ Date() }
    public var isValid:Bool{ !name.isEmpty && name.count < 128 }
    
}

// conforms to DefaultsSerializable so that it can be saved in userdefaults with SwiftyUserDefaults
extension FetchInput:DefaultsSerializable{}

struct YearMonthDay:Codable{
    public let year:Int
    public let month:Int
    public let day:Int
}

extension YearMonthDay{
    init(from date:Date){
        let calendar = Calendar(identifier: .gregorian)
        
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
}

extension YearMonthDay{
    
    /// avoiding  hard-coding date format.
    public func toString()->String{
//        let calendar = Calendar.current
//        let formatter = DateFormatter()
//        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
//        return formatter.string(from: self.toDate())
        return stringDate(from: self.toDate() )
    }
    
    public func toDate()->Date{
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(year:self.year, month: self.month, day: self.day)
        guard let date = calendar.date(from: dateComponents ) else{ fatalError("invalid date") }
        return date
    }
    
}

///Now only considering ABO blood group. not RH etc...
enum ABOBloodType:String,Codable{
    case a = "a"
    case b = "b"
    case ab = "ab"
    case o = "o"
}

///conform to CaseIterable and Identifiable to be used in ForEach
extension ABOBloodType:CaseIterable,Identifiable{
    var id: String { rawValue }
}




