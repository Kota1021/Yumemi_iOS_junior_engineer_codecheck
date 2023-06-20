////https://techblog.recochoku.jp/8437
//
//
//import CoreData
//import XCTest
//
//final class CoreDataStorageTests: XCTestCase {
//    override func setUp() {
//        super.setUp()
// 
//        let persistentContainer: NSPersistentContainer = {
//            let container = NSPersistentContainer(name: "History")
// 
//            // メモリに書き込みを行う設定
//            let description = NSPersistentStoreDescription()
//            description.url = URL(fileURLWithPath: "/dev/null")
//            container.persistentStoreDescriptions = [description]
// 
//            container.loadPersistentStores { _, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
// 
//            return container
//        }()
// 
////        CoreDataManager.shared.inject(persistentContainer)
////        let description = NSPersistentStoreDescription()
////           description.type = NSInMemoryStoreType
////           description.shouldAddStoreAsynchronously = false // Make it simpler in test env
////            persistentContainer.persistentStoreDescriptions = [description]
//    }
//    
//    private let context = CoreDataManager.shared.viewContext
// 
//    override func tearDown() {
//        super.tearDown()
// 
//        CoreDataManager.shared.deleteAllObjects()
//    }
// 
//    func test_CoreDataのモデルエンティティを生成できる() {
//        // act
//        let history: History = CoreDataStorage.entity()
// 
//        // assert
//        XCTAssertNotNil(history)
//    }
// 
//    func test_CoreDataから果物を取得できる() {
//        // arrange
//        let history = History(context: context)
//        history.prefecture = "東京都"
//        history.name = "松本幸太郎"
//        history.birthday = Date()
//        history.bloodType = .a
//        history.fetchedAt = Date()
// 
//        context.insert(history)
//        context.saveIfNeeded()
// 
//        // act
//        let firstResult: [History] = CoreDataStorage.read()
// 
//        // assert
//        XCTAssertEqual(firstResult.count, 1)
//        XCTAssertTrue(firstResult.contains(history))
// 
//        // arrange
//        let history1 = History(context: context)
//        history1.prefecture = "兵庫県"
//        history1.name = "あああ"
//        history1.birthday = Date()
//        history1.bloodType = .a
//        history1.fetchedAt = Date()
// 
//        context.insert(history1)
//        context.saveIfNeeded()
// 
//        // act
//        let secondResult: [History] = CoreDataStorage.read()
// 
//        // assert
//        XCTAssertEqual(secondResult.count, 2)
//        XCTAssertTrue(secondResult.contains(history1))
//    }
// 
//    func test_CoreDataに果物を追加できる() {
//        // arrange
//        let history = History(context: context)
//        history.prefecture = "東京都"
//        history.name = "松本幸太郎"
//        history.birthday = Date()
//        history.bloodType = .a
//        history.fetchedAt = Date()
// 
//        context.insert(history)
//        context.saveIfNeeded()
// 
//        // act
//        CoreDataStorage.create(history)
// 
//        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
//        let result = try! context.fetch(fetchRequest)
// 
//        // assert
//        XCTAssertEqual(result.count, 1)
//        XCTAssertTrue(result.contains(history))
//    }
// 
//    func test_CoreDataから果物を削除できる() {
//        // arrange
//        let history = History(context: context)
//        history.prefecture = "東京都"
//        history.name = "松本幸太郎"
//        history.birthday = Date()
//        history.bloodType = .a
//        history.fetchedAt = Date()
// 
//        context.insert(history)
//        context.saveIfNeeded()
// 
//        // act
//        CoreDataStorage.delete(history)
// 
//        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
//        let result = try! context.fetch(fetchRequest)
// 
//        // assert
//        XCTAssertEqual(result.count, 0)
//        XCTAssertFalse(result.contains(history))
//    }
// 
//    func test_CoreData内の果物を更新できる() {
//        // arrange
//        let history = History(context: context)
//        history.prefecture = "東京都"
//        history.name = "松本幸太郎"
//        history.birthday = Date()
//        history.bloodType = .a
//        history.fetchedAt = Date()
// 
//        context.insert(history)
//        context.saveIfNeeded()
// 
//        // act
//        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
//        let beforeResult = try! context.fetch(fetchRequest)
//        beforeResult.first!.prefecture = "東京都"
//        beforeResult.first!.name = "松本幸太郎"
//        beforeResult.first!.birthday = Date()
//        beforeResult.first!.bloodType = .a
//        beforeResult.first!.fetchedAt = Date()
//        beforeResult.first!.prefecture = "東京都"
// 
//        CoreDataStorage.update()
// 
//        let afterResult = try! context.fetch(fetchRequest)
// 
//        // assert
//        XCTAssertEqual(afterResult.count, 1)
//        XCTAssertEqual(afterResult.first!.prefecture, "東京都")
//        XCTAssertEqual(afterResult.first!.name, "松本幸太郎")
//        XCTAssertEqual(afterResult.first!.birthday, Date() )
//        XCTAssertEqual(afterResult.first!.bloodType, .a)
//        XCTAssertEqual(afterResult.first!.fetchedAt, Date() )
//    }
//}
