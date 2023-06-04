//
//  LuckyPrefecture.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import Foundation

struct LuckyPrefecture:Decodable{
    public let name:String
    public let brief:String
    public let capital:String
    public let citizenDay:MonthDay?
    public let hasCoastLine:Bool
    public let logoUrl:URL
}

struct MonthDay:Codable{
    let month:Int
    let day:Int
}

extension MonthDay{
    public func toString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        return formatter.string(from: self.toDate())
    }
    
    public func toDate()->Date{
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(month: self.month, day: self.day)
        guard let date = calendar.date(from: dateComponents ) else{ fatalError("invalid date") }
        return date
    }
}

