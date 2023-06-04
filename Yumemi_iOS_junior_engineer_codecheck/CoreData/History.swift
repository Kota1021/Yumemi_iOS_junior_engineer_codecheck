//
//  History.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

//import Foundation
//import CoreData
//
//@objc(History)
//public class History: NSManagedObject {
//
//}
//
//extension History {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
//        return NSFetchRequest<History>(entityName: "History")
//    }
//
//    @NSManaged public var prefecture: Data?
//    @NSManaged public var userInput: Data?
//
//}
//
//extension History : Identifiable {
//
//}

struct History{
    let prefecture:Prefecture
    let userInput:UserInput
}
