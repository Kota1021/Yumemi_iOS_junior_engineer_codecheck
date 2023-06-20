////
////  History.swift
////  Yumemi_iOS_junior_engineer_codecheckUITests
////
////  Created by 松本幸太郎 on 2023/06/06.
////
//
//import CoreData
//
//@objc(History)
//public class History: NSManagedObject {
//
//    public override var description: String {
//        return "History"
//    }
//}
//
//extension History {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
//        return NSFetchRequest<History>(entityName: "History")
//    }
//
//    @NSManaged public var prefecture: String
//    @NSManaged public var name: String
//    @NSManaged public var birthday: Date
//    // Below: bloodType data is saved as String since Core Data cannnot handle enum data. and this property is (set) private, you have to set this property via public bloodType property
//    @NSManaged private(set) var stringBloodType: String
//    @NSManaged public var fetchedAt: Date
//
//}
//
//extension History {
//    var bloodType: ABOBloodType {
//        get {
//            guard let bloodType = ABOBloodType(rawValue: self.stringBloodType) else {
//                fatalError(
//                    "bloodType in CoreData Entity (String Type) could not be transformed into ABOBloodType Type"
//                )
//            }
//            return bloodType
//        }
//        set {
//            self.stringBloodType = newValue.rawValue
//        }
//    }
//    var stringBirthday: String { stringDate(from: self.birthday) }
//    var stringFetchDate: String { stringDate(from: self.fetchedAt) }
//
//}
//
//extension History {
//    static func find(key: String) -> History? {
//        let predicate = NSPredicate(format: "name == %@", key)
//        return CoreDataStorage.read(predicate: predicate).first
//    }
// 
//    static func create(prefecture: String, name: String,birthday:Date,stringBlood:ABOBloodType,fetchedAt:Date) -> History {
//        let history: History = CoreDataStorage.entity()
//        
//        history.prefecture = prefecture
//        history.name = name
//        history.birthday = birthday
//        history.bloodType = stringBlood
//        history.fetchedAt = fetchedAt
//        
//        return history
//    }
// 
//    static func update(key: String, prefecture: String, name: String,birthday:Date,stringBlood:ABOBloodType,fetchedAt:Date) {
//        if let history = find(key: key) {
//            history.prefecture = prefecture
//            history.name = name
//            history.birthday = birthday
//            history.bloodType = stringBlood
//            history.fetchedAt = fetchedAt
//        }
//    }
//}
//
//func stringDate(from date: Date) -> String {
//    let formatter = DateFormatter()
//    formatter.dateFormat = DateFormatter.dateFormat(
//        fromTemplate: "yyyydMMM", options: 0, locale: Locale.current)
//    return formatter.string(from: date)
//}
//
/////Now only considering ABO blood group. not RH etc...
//enum ABOBloodType: String, Codable {
//    case a = "a"
//    case b = "b"
//    case ab = "ab"
//    case o = "o"
//}
//
/////conform to CaseIterable and Identifiable to be used in ForEach
//extension ABOBloodType: CaseIterable, Identifiable {
//    var id: String { rawValue }
//}
