//
//  SavedLuckyPrefecture.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import CoreData

///saving LuckyPrefecture, not Prefecture, this is because Prefecture = LuckyPrefecture + PinLocation + PrefectureImageInfo
///PinLocation and PrefectureImageInfo data is derived from JSON.
///To make it SSOT, you cant save those data.
@objc(StoredYumemiAPIPrefecture)
public class StoredYumemiAPIPrefecture: NSManagedObject {}
//extension StoredLuckyPrefecture : Identifiable {}

extension StoredYumemiAPIPrefecture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredYumemiAPIPrefecture> {
        return NSFetchRequest<StoredYumemiAPIPrefecture>(entityName: "StoredYumemiAPIPrefecture")
    }

    @NSManaged public var name: String
    @NSManaged public var brief: String
    @NSManaged public var capital: String
    @NSManaged private(set) var citizenDayInDate: Date?
    @NSManaged public var hasCoastLine: Bool
    @NSManaged private var logoURLString: String

}

extension StoredYumemiAPIPrefecture{
    public var logoURL:URL{
        get {
            guard let url = URL(string: self.logoURLString) else {
                fatalError("logoURLString in CoreData Entity could not be transformed into URL") }
            return url
        }
        set {
            self.logoURLString = newValue.absoluteString
        }
    }
    
    var citizenDay:MonthDay?{
        get{
            guard let citizenDayInDate = citizenDayInDate else{ return nil }
            return MonthDay(from: citizenDayInDate)
        }set{
            self.citizenDayInDate = newValue?.toDate()
        }
    }
}



