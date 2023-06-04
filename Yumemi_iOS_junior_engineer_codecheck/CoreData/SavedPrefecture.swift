//
//  SavedPrefecture.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import CoreData

@objc(SavedPrefecture)
public class SavedPrefecture: NSManagedObject {

}

extension SavedPrefecture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPrefecture> {
        return NSFetchRequest<SavedPrefecture>(entityName: "SavedPrefecture")
    }

    @NSManaged public var name: String
    @NSManaged public var brief: String
    @NSManaged public var capital: String
    @NSManaged public var citizenDay: Date?
    @NSManaged public var hasCoastLine: Bool
    @NSManaged private var logoURLString: String
    @NSManaged public var location: Data
    @NSManaged public var images: Data
    
//    //from JSON
//    let location:PinLocation
//
//    //from JSON and then website "find47"
//    let images:[PrefectureImageInfo]

}

extension SavedPrefecture{
    var logoURL:URL{
        get {
            guard let url = URL(string: self.logoURLString) else {
                fatalError("logoURLString in CoreData Entity could not be transformed into URL") }
            return url
        }
        set {
            self.logoURLString = newValue.absoluteString
        }
    }
}


extension SavedPrefecture : Identifiable {

}
