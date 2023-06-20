////
////  CoreDataStrage.swift
////  Yumemi_iOS_junior_engineer_codecheckUITests
////
////  Created by 松本幸太郎 on 2023/06/06.
////
//
//import CoreData
//
//struct CoreDataStorage<T: NSManagedObject> {
//    static var context: NSManagedObjectContext {
//        CoreDataManager.shared.viewContext
//    }
// 
//    static func entity() -> T {
//        let entity = NSEntityDescription.entity(
//            forEntityName: String(describing: T.self),
//            in: context
//        )!
// 
//        return T(entity: entity, insertInto: nil)
//    }
// 
//    static func read(
//        sortDescriptors: [NSSortDescriptor] = [],
//        predicate: NSPredicate? = nil,
//        fetchLimit: Int = 0
//    ) -> [T] {
//        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
//        fetchRequest.sortDescriptors = sortDescriptors
//        fetchRequest.predicate = predicate
//        fetchRequest.fetchLimit = fetchLimit
// 
//        guard let result = try? context.fetch(fetchRequest) else {
//            return []
//        }
// 
//        return result
//    }
// 
//    static func create(_ object: T) {
//        context.insert(object)
//        context.saveIfNeeded()
//    }
// 
//    static func update() {
//        context.saveIfNeeded()
//    }
// 
//    static func delete(_ object: T) {
//        context.delete(object)
//        context.saveIfNeeded()
//    }
//}
