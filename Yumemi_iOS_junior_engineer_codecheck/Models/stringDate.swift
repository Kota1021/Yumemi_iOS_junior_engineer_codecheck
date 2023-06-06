//
//  History.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//
import Foundation

/// avoiding  hard-coding date format.
/// Shared by History and FetchInput
func stringDate(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = DateFormatter.dateFormat(
        fromTemplate: "yyyydMMM", options: 0, locale: Locale.current)
    return formatter.string(from: date)
}
