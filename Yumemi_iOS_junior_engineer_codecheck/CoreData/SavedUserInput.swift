//
//  UserInputEntity.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import Foundation
import CoreData

@objc(SavedUserInput)
public class SavedUserInput: NSManagedObject {

}

extension SavedUserInput {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUserInput> {
        return NSFetchRequest<SavedUserInput>(entityName: "SavedUserInput")
    }

    @NSManaged public var name: String
    @NSManaged public var birthday: Data
    @NSManaged public var bloodType: String
    @NSManaged public var fetchedAt: Data

}

extension SavedUserInput : Identifiable {

}




extension SavedUserInput{
    var bloodTypeToAndFromString:ABOBloodType{
        get {
            guard let bloodType = ABOBloodType(rawValue: self.bloodType) else {
                fatalError("bloodType in CoreData Entity (String Type) could not be transformed into ABOBloodType Type") }
            return bloodType
        }
        set {
            self.bloodType = newValue.rawValue
        }
    }
}
