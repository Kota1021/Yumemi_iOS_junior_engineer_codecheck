//
//  UserInputEntity.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

//import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject {

    public override var description: String {
        return "History"
    }
}

extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var prefecture: String
    @NSManaged public var name: String
    @NSManaged public var birthday: Date
    @NSManaged private(set) var stringBloodType: String  // This bloodType data is saved as String scence Core Data cannnot handle enum data. and this property is private, you have to get/set this property via bloodType property
    @NSManaged public var fetchedAt: Date

}

extension History {
    var bloodType: ABOBloodType {
        get {
            guard let bloodType = ABOBloodType(rawValue: self.stringBloodType) else {
                fatalError(
                    "bloodType in CoreData Entity (String Type) could not be transformed into ABOBloodType Type"
                )
            }
            return bloodType
        }
        set {
            self.stringBloodType = newValue.rawValue
        }
    }
    var stringBirthday: String { stringDate(from: self.birthday) }
    var stringFetchDate: String { stringDate(from: self.fetchedAt) }

}
// conforms to Identifiable to be used in ForEach
extension History: Identifiable {}
