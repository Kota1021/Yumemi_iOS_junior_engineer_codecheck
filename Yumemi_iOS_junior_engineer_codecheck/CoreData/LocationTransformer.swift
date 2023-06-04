//
//  PinLocationTransformer.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

//import Foundation
//
//class LocationTransformer:ValueTransformer{
//
//    /// from Object to CoreData
//    override func transformedValue(_ value: Any?) -> Any? {
//        guard let location = value as? PinLocation else { return nil }
//        do{
//            let data = try NSKeyedArchiver.archivedData(withRootObject: location, requiringSecureCoding: true)
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
//            let location = try NSKeyedUnarchiver.unarchivedObject(ofClass: PinLocation, from: data)
//            return location
//        }catch{
//            return nil
//        }
//    }
//}
