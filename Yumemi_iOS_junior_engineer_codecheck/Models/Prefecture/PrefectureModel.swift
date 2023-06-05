//
//  PrefectureModel.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import Alamofire
import Combine
import CoreData
import Foundation

protocol PrefectureModelProtocol: ObservableObject {
    var prefecture: Prefecture? { get set }
    var error: AFError? { get }
    func fetchLuckyPrefecture(
        input: FetchInput,
        onReceive actionOnReceive: @escaping () -> Void,
        onSuccess actionOnSuccess: @escaping (YumemiAPIPrefecture) -> Void,
        onFailure actionOnFalure: @escaping () -> Void)
    func setPrefecture(name: String)
}

//PrefectureModel does not know view
class PrefectureModel: ObservableObject, PrefectureModelProtocol {
    @Published public var prefecture: Prefecture?
    @Published private(set) var error: AFError? = nil

    public func fetchLuckyPrefecture(
        input: FetchInput,
        onReceive actionOnReceive: @escaping () -> Void = {},
        onSuccess actionOnSuccess: @escaping (YumemiAPIPrefecture) -> Void = { _ in },
        onFailure actionOnFalure: @escaping () -> Void = {}
    ) {
        print("PrefectureModel: fetchLuckyPrefecture called")
        let api = FortuneAPI()

        //If you set JSONDecoder.keyDecodingStrategy's value into .convertFromSnakeCase, it will automatically change snake_case into camelCase, and vice versa. Thus no need for CordingKeys. cf. https://zenn.dev/u_dai/articles/af5e2bf083b0dc
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        AF.request(
            api.url, method: .post, parameters: input, encoder: .json(encoder: encoder),
            headers: api.headers
        )
        .responseDecodable(of: YumemiAPIPrefecture.self, decoder: decoder) { response in
            actionOnReceive()
            switch response.result {
            case .success:
                if let luckyPrefecture = response.value {
                    self.setPrefecture(from: luckyPrefecture)
                    print("PrefectureModel: fetched:\n\(luckyPrefecture)\n")
                    self.storeYumemiAPIPrefecture(luckyPrefecture)
                    print("PrefectureModel: and stored it in CoreData.\n\n")
                    actionOnSuccess(luckyPrefecture)
                } else {
                    print("PrefectureModel: luckyPrefecture is nil")
                }
            case .failure(let error):
                self.error = error
                print("PrefectureModel: failed to fetch luckyPrefecture")
                actionOnFalure()
            }
        }
    }

    private func setPrefecture(from luckyPrefecture: YumemiAPIPrefecture) {
        let location: PinLocation = PrefectureLocations.location(of: luckyPrefecture.name)
        let images: [PrefectureImageInfo] = ImageInfoSets.items(of: luckyPrefecture.name)

        self.prefecture = Prefecture(
            name: luckyPrefecture.name,
            brief: luckyPrefecture.brief,
            capital: luckyPrefecture.capital,
            citizenDay: luckyPrefecture.citizenDay,
            hasCoastLine: luckyPrefecture.hasCoastLine,
            logoUrl: luckyPrefecture.logoUrl,
            location: location,
            images: images)
    }

    private func setPrefecture(from luckyPrefecture: StoredYumemiAPIPrefecture) {
        let location: PinLocation = PrefectureLocations.location(of: luckyPrefecture.name)
        let images: [PrefectureImageInfo] = ImageInfoSets.items(of: luckyPrefecture.name)

        self.prefecture = Prefecture(
            name: luckyPrefecture.name,
            brief: luckyPrefecture.brief,
            capital: luckyPrefecture.capital,
            citizenDay: luckyPrefecture.citizenDay,
            hasCoastLine: luckyPrefecture.hasCoastLine,
            logoUrl: luckyPrefecture.logoURL,
            location: location,
            images: images)
    }

    private let viewContext = PersistenceController.shared.container.viewContext

    //CoreData のPrefectureエンティティをnameで検索し、ヒットしたものを代入
    public func setPrefecture(name: String) {
        let yumemiAPIPrefecture = fetchYumemiAPIPrefectures().first { $0.name == name }!
        setPrefecture(from: yumemiAPIPrefecture)
    }

    private func fetchYumemiAPIPrefectures() -> [StoredYumemiAPIPrefecture] {
        let context: NSManagedObjectContext = viewContext
        let request = NSFetchRequest<StoredYumemiAPIPrefecture>(
            entityName: "StoredYumemiAPIPrefecture")

        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error:", error)
            return []
        }
    }

    private func storeYumemiAPIPrefecture(_ value: YumemiAPIPrefecture) {
        let newLuckyPrefecture = StoredYumemiAPIPrefecture(context: viewContext)
        newLuckyPrefecture.name = value.name
        newLuckyPrefecture.brief = value.brief
        newLuckyPrefecture.capital = value.capital
        newLuckyPrefecture.citizenDay = value.citizenDay
        newLuckyPrefecture.hasCoastLine = value.hasCoastLine
        newLuckyPrefecture.logoURL = value.logoUrl

        print("InputViewModel: saving userInfo into Core Data")
        try? viewContext.save()
    }

}

func getYumemiAPIPrefecture(from: StoredYumemiAPIPrefecture) {

}
