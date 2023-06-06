//
//  PrefectureTransformer.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//
//
//import Foundation
////import AppKit
//
//class PrefectureTransformer:ValueTransformer{
//
//    /// from Object to CoreData
//    override func transformedValue(_ value: Any?) -> Any? {
//        guard let prefecture = value as? Prefecture else { return nil }
//        do{
//            let data = try NSKeyedArchiver.archivedData(withRootObject: prefecture, requiringSecureCoding: true)
//            return data
//        }catch{
//            return nil
//        }
//    }
//
//    /// ///from CoreData to Object
//    override func reverseTransformedValue(_ value: Any?) -> Any? {
//        guard let data = value as? Data else { return nil }
//        do{
//            let prefecture = try NSKeyedUnarchiver.unarchivedObject(ofClass: Prefecture, from: data)
//            return prefecture
//        }catch{
//            return nil
//        }
//    }
//}
