//
//  UserInputEntity.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

//import Foundation
import CoreData

@objc(StoredHistory)
public class StoredHistory: NSManagedObject {
    
    public override var description: String {
        return "StoredHistory"
    }
}
//extension StoredHistory : Identifiable {}

extension StoredHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredHistory> {
        return NSFetchRequest<StoredHistory>(entityName: "StoredHistory")
    }

    @NSManaged public var prefecture: String
    @NSManaged public var name: String
    @NSManaged public var birthday: Date
    @NSManaged private(set) var bloodTypeString: String // This bloodType data is saved as String scence Core Data cannnot handle enum data. and this property is private, you have to get/set this property via bloodType property
    @NSManaged public var fetchedAt: Date

}

extension StoredHistory{
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
    var stringBirthday:String{ stringDate(from: self.birthday) }
    var stringFetchDate:String{ stringDate(from: self.fetchedAt) }
    
}



extension StoredHistory:Identifiable{}
