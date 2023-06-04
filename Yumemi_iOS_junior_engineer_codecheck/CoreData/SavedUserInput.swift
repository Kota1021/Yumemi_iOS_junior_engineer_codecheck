//
//  UserInputEntity.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

//import Foundation
import CoreData

@objc(SavedUserInput)
public class SavedUserInput: NSManagedObject {

}

extension SavedUserInput {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUserInput> {
        return NSFetchRequest<SavedUserInput>(entityName: "SavedUserInput")
    }

    @NSManaged public var name: String
    @NSManaged public var birthday: Date
    @NSManaged private var bloodTypeString: String // This bloodType data is saved as String scence Core Data cannnot handle enum data. and this property is private, you have to get/set this property via "bloodType"
    @NSManaged public var fetchedAt: Date

}

extension SavedUserInput{
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


extension SavedUserInput : Identifiable {

}
