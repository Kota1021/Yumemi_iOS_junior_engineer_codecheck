////https://techblog.recochoku.jp/8437
//import CoreData
//
//final class CoreDataManager {
//    private(set) lazy var viewContext = persistentContainer.viewContext
// 
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Yumemi_iOS_junior_engineer_codecheck")
// 
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
// 
//        return container
//    }()
// 
//    static let shared = CoreDataManager()
//    private init() {}
//}
// 
//extension CoreDataManager {
//    func deleteAllObjects() {
//        persistentContainer.managedObjectModel.entities
//            .compactMap(\.name)
//            .forEach {
//                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: $0)
//                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
// 
//                do {
//                    try persistentContainer.viewContext.execute(batchDeleteRequest)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
// 
//        persistentContainer.viewContext.reset()
//    }
//}
// 
//extension NSManagedObjectContext {
//    func saveIfNeeded() {
//        if !hasChanges {
//            return
//        }
// 
//        do {
//            try save()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
// 
