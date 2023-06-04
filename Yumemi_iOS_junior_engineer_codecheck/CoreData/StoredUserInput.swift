//
//  UserInputEntity.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

//import Foundation
import CoreData

@objc(SavedUserInput)
public class StoredUserInput: NSManagedObject {

}

extension StoredUserInput {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredUserInput> {
        return NSFetchRequest<StoredUserInput>(entityName: "SavedUserInput")
    }

    @NSManaged public var name: String
    @NSManaged public var birthday: Date
    @NSManaged private var bloodTypeString: String // This bloodType data is saved as String scence Core Data cannnot handle enum data. and this property is private, you have to get/set this property via "bloodType"
    @NSManaged public var fetchedAt: Date

}

extension StoredUserInput{
    var bloodType:ABOBloodType{
        get {
            guard let bloodType = ABOBloodType(rawValue: self.bloodTypeString) else {
                fatalError("bloodType in CoreData Entity (String Type) could not be transformed into ABOBloodType Type") }
            return bloodType
        }
        set {
            self.bloodTypeString = newValue.rawValue
        }
    }
}


extension StoredUserInput : Identifiable {

}
