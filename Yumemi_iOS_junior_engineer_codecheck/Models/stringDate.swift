//
//  History.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//
import Foundation

func stringDate(from date:Date)->String{
    let calendar = Calendar.current
    let formatter = DateFormatter()
    formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
    return formatter.string(from: date)
}
